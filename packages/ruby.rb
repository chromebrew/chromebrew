require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.4.1'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.xz'
  source_sha256 '4fc8a9992de3e90191de369270ea4b6c1b171b7941743614cc50822ddc1fe654'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7bbdd4234a0db3ca0a9b368513b05d23e4e7c347506f89647bd71892f3d85ed3',
     armv7l: '7bbdd4234a0db3ca0a9b368513b05d23e4e7c347506f89647bd71892f3d85ed3',
       i686: 'e52ad60357b2dd198b701eb11caf3ee8b0c3d61ad4c428233476a43a3ec9612f',
     x86_64: 'c6660e493c4f7caa5c2e677841eec754eaeb88b76352d59d80764fb3f3445638',
  })

  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'openssl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    system "CC='gcc' ./configure --libdir=#{CREW_LIB_PREFIX} --enable-shared"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "TMPDIR=/usr/local/tmp make check"
  end
end
