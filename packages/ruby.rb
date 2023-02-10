require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.2.1' # Do not use @_ver here, it will break the installer.
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.1.tar.gz'
  source_sha256 '13d67901660ee3217dbd9dd56059346bd4212ce64a69c306ef52df64935f8dbd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.1_armv7l/ruby-3.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.1_armv7l/ruby-3.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.1_i686/ruby-3.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.2.1_x86_64/ruby-3.2.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cf8852042ea62836af0274d8fb7f5a89db69ccd486ed6745280b75bd28004d09',
     armv7l: 'cf8852042ea62836af0274d8fb7f5a89db69ccd486ed6745280b75bd28004d09',
       i686: '835e328f91883740d25477c82c998a2361c6f5647e70786900c85ef53f412d92',
     x86_64: '56bd07418efda0107bdb5eb2acb52940f6fee7e2286bfc4c97f1cfc2ce70185c'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'filecmd' # L (This is to enable file command use in package files.)
  depends_on 'gmp' # R
  depends_on 'gcc' # R
  depends_on 'libffi' # R
  depends_on 'openssl' # R
  depends_on 'libyaml' # R
  depends_on 'readline' # R
  depends_on 'rust' => :build
  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems

  # at run-time, system's gmp, openssl, readline and zlibpkg can be used

  no_patchelf
  no_zstd

  def self.build
    @yjit = ARCH == 'x86_64' ? '--enable-yjit' : ''
    system '[ -x configure ] || autoreconf -fiv'
    system "RUBY_TRY_CFLAGS='stack_protector=no' \
      RUBY_TRY_LDFLAGS='stack_protector=no' \
      optflags='-flto=auto -fuse-ld=#{CREW_LINKER}' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared \
      #{@yjit} \
      --disable-fortify-source"
    system 'make'
  end

  def self.check
    # Do not run checks if rebuilding current ruby version.
    # RUBY_VERSION is a built-in ruby constant.
    system 'make check || true' unless RUBY_VERSION == '3.2.0'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Gems are stored in a ruby majorversion.minorversion.0 folder.
    @gemrc = <<~GEMRCEOF
      gem: --no-document
      gempath: #{CREW_LIB_PREFIX}/ruby/gems/3.2.0
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
