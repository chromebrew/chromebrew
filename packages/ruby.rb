require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.4.7'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  # git_hashtag '07f7832cffea879946a796e066ccb13ccb4b2abd'
  git_hashtag "v#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed00074cbd2a2850b1ea670cfce785da896b5f3bb9f4080a437634b46e72e576',
     armv7l: 'ed00074cbd2a2850b1ea670cfce785da896b5f3bb9f4080a437634b46e72e576',
       i686: '42a64a50cd9dfc6d3cba665e573994cdb8826c2ea7be6b7124e84b743cbd81c6',
     x86_64: '0fbe3c76c23db1d759016ef2f74e922b3ff9177eb1cc02d8427089a05001580e'
  })

  depends_on 'ca_certificates' # L
  depends_on 'filecmd' # L (This is to enable file command use in package files.)
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libffi' # R
  depends_on 'libxcrypt' # R
  depends_on 'libyaml' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build
  depends_on 'zlib' # R

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
    system "MAKEFLAGS='--jobs #{CREW_NPROC}' make check || true" unless version.split('-')[0] == RUBY_VERSION
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
    system 'update_rubygems'
    # install for Ruby 3.4
    system 'gem uninstall resolv-replace', exception: false
    system 'gem install highline ptools'
    system "gem update #{'--silent' unless @opt_verbose} -N --system", exception: false
  end
end
