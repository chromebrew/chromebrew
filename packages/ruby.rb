require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.5.0'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.xz'
  source_sha256 '1da0afed833a0dab94075221a615c14487b05d0c407f991c8080d576d985b49b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ad6bad7fcce9b595af3172e6ae48a2b4ffac7e0ed73daa22be4e972f4889c3a6',
     armv7l: 'ad6bad7fcce9b595af3172e6ae48a2b4ffac7e0ed73daa22be4e972f4889c3a6',
       i686: '01bb17f706dc73013f23c15d589744858e1501c6664feef73dad1ff0e9b67599',
     x86_64: '1c748efef37747afb9b4f11068a2bbbaf03495bcb697310e1a39bb82a3549c71',
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
