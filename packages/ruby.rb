require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.1-994b505'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/ruby/archive/994b505ffb0bf9eb795525199b47697412a98abb.zip'
  source_sha256 '247155fd6978dffea5f1f25e7a77d1fe3c29c224ad24e15384c49e7e0aa71761'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1-994b505_armv7l/ruby-3.1-994b505-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1-994b505_armv7l/ruby-3.1-994b505-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1-994b505_i686/ruby-3.1-994b505-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1-994b505_x86_64/ruby-3.1-994b505-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ffa3f5aea7408599aab2d074876b30484bd845abf79dfffef8646fd8c38b7292',
     armv7l: 'ffa3f5aea7408599aab2d074876b30484bd845abf79dfffef8646fd8c38b7292',
       i686: '78180a2bbfbaadbbb0cfa8a6f3d9c3fe741da922dbf0242b53a4f6676d11e6d5',
     x86_64: 'ae3cf478808d30321e87db6433f38d0886cf38adef123eba0e0a826b6c6367f1'
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
  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems

  # at run-time, system's gmp, openssl, readline and zlibpkg can be used

  no_patchelf
  no_zstd

  def self.build
    system '[ -x configure ] || autoreconf -fiv'
    system "RUBY_TRY_CFLAGS='stack_protector=no' \
      RUBY_TRY_LDFLAGS='stack_protector=no' \
      optflags='-flto -fuse-ld=#{CREW_LINKER}' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared \
      --disable-fortify-source"
    system 'make'
  end

  def self.check
    # Do not run checks if rebuilding current ruby version.
    # RUBY_VERSION is a built-in ruby constant.
    system 'make check || true' unless RUBY_VERSION == @_ver
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts 'Updating ruby gems. This may take a while...'
    unless Kernel.system("grep -q \"no-document\" #{HOME}/.gemrc")
      File.write("#{HOME}/.gemrc", "gem: --no-document\n",
                   mode: 'a')
    end
    unless Kernel.system("grep -q \"gempath\" #{HOME}/.gemrc")
      File.write("#{HOME}/.gemrc", "gempath: #{CREW_LIB_PREFIX}/ruby/gems/3.1.0\n",
                   mode: 'a')
    end
    silent = @opt_verbose ? '' : '--silent'
    system "gem update #{silent} -N --system"
  end
end
