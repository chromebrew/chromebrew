require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.0.0-1'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.0.tar.gz'
  source_sha256 'a13ed141a1c18eb967aac1e33f4d6ad5f21be1ac543c344e0d6feeee54af8e28'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '0849babd7e1abb994314af2a04b3612085e7ca19a91cbd50642cbccb092b577c',
      armv7l: '0849babd7e1abb994314af2a04b3612085e7ca19a91cbd50642cbccb092b577c',
        i686: 'ed9cfb4bd99c3423b2a464c07c748820ec3b640f4bc13d4c6c8b1d88b76f1e89',
      x86_64: '0b21fef16a94cfb9e2815f028d2e8aad2c32554d09ff09d485a2fc5dcfa06c34',
  })

  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'openssl' => :build
  # depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    # The download from ruby-lang.org doesn't need autoconf run,
    # but the download from github does.
    #system "autoconf"
    system "CFLAGS='-ltinfo -flto=auto' CXXFLAGS='-flto=auto' \
    LDFLAGS='-flto=auto' \
    optflags='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --enable-shared \
    --disable-fortify-source"
    system 'make'
  end

  def self.check
    system "TMPDIR=#{CREW_PREFIX}/tmp make check || true"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
