require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.3.2' # Do not use @_ver here, it will break the installer.
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby.git'
  git_hashtag "v#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '04a4d8f4aeace76c4591f9e9938ad9cd3ef8fb4dcaacc3fefcae5b24cd58d442',
     armv7l: '04a4d8f4aeace76c4591f9e9938ad9cd3ef8fb4dcaacc3fefcae5b24cd58d442',
       i686: '4be5ce0267aae23064bb49e638cfd6947f6218cd4aadb95124664ac3ba39dd32',
     x86_64: '1b2ca2376ee68605a047a0089db5933e08274920792915a82cfd034fadbac9db'
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
  depends_on 'zlibpkg' # R

  conflicts_ok # Needed for successful build.

  # at run-time, system's gmp, openssl, and zlibpkg can be used

  def self.patch
    return if ARCH == 'x86_64'

    # Address 32-bit compatibility issue as per
    # https://bugs.ruby-lang.org/issues/20447
    # and also https://bugs.gentoo.org/932841
    downloader 'https://github.com/ruby/ruby/pull/10332.patch', '293d89bb274407ad825941d8f4ea4bce81bace93281e1e069f0a715607ecd405'
    system 'patch -Np1 -i 10332.patch'
  end

  def self.build
    system '[ -x configure ] || autoreconf -fiv'
    system "RUBY_TRY_CFLAGS='stack_protector=no' \
      RUBY_TRY_LDFLAGS='stack_protector=no' \
      optflags='-flto=auto -fuse-ld=#{CREW_LINKER}' \
      mold -run ./configure #{CREW_OPTIONS} \
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
    system "gem update #{silent} -N --system", exception: false
  end
end
