require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.1.0'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.1/ruby-3.1.0.tar.xz'
  source_sha256 '1a0e0b69b9b062b6299ff1f6c6d77b66aff3995f63d1d8b8771e7a113ec472e2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.0_armv7l/ruby-3.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.0_armv7l/ruby-3.1.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.0_i686/ruby-3.1.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.1.0_x86_64/ruby-3.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '07955a6a3641548d6ca1fbb257bc0916f457b476fd9989e2aa6eb0a72814e4a2',
     armv7l: '07955a6a3641548d6ca1fbb257bc0916f457b476fd9989e2aa6eb0a72814e4a2',
       i686: '4a58bed3d0afb75d1534ca5209035bcc7b39418c4ed246d051498204d988e669',
     x86_64: 'a131ef54d11f48988b65195e8d7b2d954b7a7adce8fdf3b61e74db6f605e177f'
  })

  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    # The download from ruby-lang.org doesn't need autoconf run,
    # but the download from github does.
    system '[ -x configure ] || autoreconf -fiv'
    system "env RUBY_CONF_ENV='stack_protector=no' \
    CFLAGS='-ltinfow -flto=auto' CXXFLAGS='-flto=auto' \
    LDFLAGS='-flto=auto' \
    optflags='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --enable-shared \
    --disable-fortify-source"
    system 'make'
  end

  def self.check
    system 'make check || true'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'gem update --silent -N --system'
  end
end
