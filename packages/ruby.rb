require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '4.0.2'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ace2cc659bf213bd8e792e4ec27773a925fcd6ba1a977402e9b5a16da5a17fee',
     armv7l: 'ace2cc659bf213bd8e792e4ec27773a925fcd6ba1a977402e9b5a16da5a17fee',
       i686: '3169f4db3d25295f0a8d6ff6eca907d13e82b863f44a0f198a7e3c3f9c2b5696',
     x86_64: 'bf4d0a295a756de16751f4f2e9c88e4122e8251536faa7819529725fb6a6ea48'
  })

  depends_on 'ca_certificates' => :logical
  depends_on 'filecmd' => :logical # (This is to enable file command use in package files.)
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'gmp' => :library
  depends_on 'libffi' # R
  depends_on 'libxcrypt' => :library
  depends_on 'libyaml' => :library
  depends_on 'openssl' => :library
  depends_on 'rust' => :build
  depends_on 'zlib' => :library

  conflicts_ok # Needed for successful build.

  # at run-time, system's gmp, openssl, and zlib can be used

  def self.patch
    # Download bundled gems version from Top of Tree. Otherwise outdated
    # compile needed gems during install can cause issues when updates
    # are attempted.
    downloader 'https://github.com/ruby/ruby/raw/refs/heads/master/gems/bundled_gems', 'SKIP', 'gems/bundled_gems'
  end

  def self.build
    system '[ -x configure ] || autoreconf -fiv'
    system 'filefix'
    system "RUBY_TRY_CFLAGS='stack_protector=no' \
      RUBY_TRY_LDFLAGS='stack_protector=no' \
      optflags='-flto=auto -fuse-ld=mold' \
      LD=mold \
      ./configure #{CREW_CONFIGURE_OPTIONS} \
      --enable-shared \
      #{'--enable-yjit' if ARCH == 'x86_64' || ARCH == 'aarch64'} \
      --disable-fortify-source"
    system "MAKEFLAGS='--jobs #{CREW_NPROC}' make"
  end

  def self.check
    # Do not run checks if rebuilding current ruby version.
    # RUBY_VERSION is a built-in ruby constant.
    system "MAKEFLAGS='--jobs #{CREW_NPROC}' make check || true" unless version == RUBY_VERSION
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # See https://stackoverflow.com/questions/1844118/ruby-split-string-at-character-counting-from-the-right-side.
    @ruby_ver = version.split(/\.([^.]*)$/).first
    # Gems are stored in a ruby majorversion.minorversion.0 folder.
    @gemrc = <<~GEMRCEOF
      gem: --no-document
      gempath: #{CREW_LIB_PREFIX}/ruby/gems/#{@ruby_ver}.0
    GEMRCEOF
    FileUtils.mkdir_p CREW_DEST_HOME
    File.write("#{CREW_DEST_HOME}/.gemrc", @gemrc)
  end

  def self.postinstall
    puts 'Updating ruby gems. This may take a while...'
    # update_rubygems is provided by the ruby_rubygems_update package.
    system 'gem install rubygems-update', exception: false unless File.executable?("#{CREW_PREFIX}/bin/update_rubygems")
    system 'update_rubygems', exception: false
    # install for Ruby 3.4
    system 'gem uninstall resolv-replace', exception: false
    system 'gem install highline ptools', exception: false
    system "gem update #{'--silent' unless @opt_verbose} -N --system", exception: false
  end
end
