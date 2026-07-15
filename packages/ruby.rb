require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '4.0.6'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7904b8d72c12e70642c1808be45644bdc85d4221191186e048f684d9371bcb7',
     armv7l: 'a7904b8d72c12e70642c1808be45644bdc85d4221191186e048f684d9371bcb7',
       i686: 'e38bdec01033dd4677dbd0c51856b1a3e1f1fabf040a8c03265e5d0998754f12',
     x86_64: 'a9c19ba1614d788d5c58612a040bf9f415d3b276705d3af8b90eeb861d1ac66f'
  })

  depends_on 'ca_certificates' => :logical
  depends_on 'filecmd' => :logical # (This is to enable file command use in package files.)
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
    downloader 'https://github.com/ruby/ruby/raw/refs/heads/master/gems/bundled_gems', 'SKIP', 'gems/bundled_gems' unless version == '4.0.6'
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
