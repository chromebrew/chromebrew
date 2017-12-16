require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.4.2'
  source_url 'https://cache.ruby-lang.org/pub/ruby/ruby-2.4.2.tar.xz'
  source_sha256 '748a8980d30141bd1a4124e11745bb105b436fb1890826e0d2b9ea31af27f735'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ec8ec1e43a44a848064d118c1f3b39449eaee6e357e975e376066d674361b396',
     armv7l: 'ec8ec1e43a44a848064d118c1f3b39449eaee6e357e975e376066d674361b396',
       i686: '9302e1f4812ea29285a1ff314fbf57cbb378a79ba9d71e0d11b4aa432481c68d',
     x86_64: '383da1e491bf54250b1a5403b80fafaf4077deb09b36d726627abb261d2d0918',
  })

  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'openssl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    system "CC='gcc' ./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --enable-shared"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "TMPDIR=/usr/local/tmp make check"
  end
end
