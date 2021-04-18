require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.0.1'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.1.tar.gz'
  source_sha256 '369825db2199f6aeef16b408df6a04ebaddb664fb9af0ec8c686b0ce7ab77727'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ruby-3.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ruby-3.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/ruby-3.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/ruby-3.0.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '210eb6582d1a06e7fbdbbfeb6658abed7633437de3e7faa4ebf16875e3687e28',
     armv7l: '210eb6582d1a06e7fbdbbfeb6658abed7633437de3e7faa4ebf16875e3687e28',
       i686: 'a7b5531d7d331bdaa2b822eed85dd66ecf3a9f7f04ed9227c154f9657a4d53cd',
     x86_64: '78bba3bf15210fd85ece6a0551fc0a1097c55a39f92b334a204ac97edfa2e1a5'
  })

  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    # The download from ruby-lang.org doesn't need autoconf run,
    # but the download from github does.
    # system 'autoreconf -fiv'
    system "env CFLAGS='-ltinfo -flto=auto' CXXFLAGS='-flto=auto' \
    LDFLAGS='-flto=auto' \
    optflags='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --enable-shared \
    --disable-fortify-source"
    system 'make'
  end

  def self.check
    system "make check || true"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'gem update --silent -N --system'
  end
end
