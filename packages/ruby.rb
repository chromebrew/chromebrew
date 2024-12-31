require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.4.1' # Do not use @_ver here, it will break the installer.
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag "v#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a732ccce015eab6fffeb91b79b951090838c16f55e1d581cc1a07b178f70f5b',
     armv7l: '8a732ccce015eab6fffeb91b79b951090838c16f55e1d581cc1a07b178f70f5b',
       i686: '01b9d4094733fb34c48ad611377de6f97b1137073af7ee7617d23abe6d8fdb39',
     x86_64: '417c248d4921fd5cf07569f358957528e42c293e6f7f759786fcc874f3738c7e'
  })

  depends_on 'ca_certificates' # L
  depends_on 'filecmd' # L (This is to enable file command use in package files.)
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libffi' # R
  depends_on 'libyaml' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build
  depends_on 'zlib' # R

  conflicts_ok # Needed for successful build.

  # at run-time, system's gmp, openssl, and zlib can be used

  def self.build
    system '[ -x configure ] || autoreconf -fiv'
    system "RUBY_TRY_CFLAGS='stack_protector=no' \
      RUBY_TRY_LDFLAGS='stack_protector=no' \
      optflags='-flto=auto -fuse-ld=#{CREW_LINKER}' \
      mold -run ./configure #{CREW_CONFIGURE_OPTIONS} \
      --enable-shared \
      #{ARCH == 'x86_64' ? '--enable-yjit' : ''} \
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
    silent = @opt_verbose ? '' : '--silent'
    # install for Ruby 3.4
    system 'gem uninstall resolv-replace', exception: false
    system 'gem install highline ptools'
    system "gem update #{silent} -N --system", exception: false
  end
end
