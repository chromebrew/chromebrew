require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.5.3'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.3.tar.gz'
  source_sha256 '9828d03852c37c20fa333a0264f2490f07338576734d910ee3fd538c9520846c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5e485a0320b298e1f5c4ff50d98c6fe6d06ad9a38d9119d580a8b469418e1e6a',
     armv7l: '5e485a0320b298e1f5c4ff50d98c6fe6d06ad9a38d9119d580a8b469418e1e6a',
       i686: '6f4a5b96c31ef5ee4f09ac15da4c7a4a9d838ed5233038136ead1e155d17f342',
     x86_64: '352b78fc883cf8936136991fda9ca5d49e90b2951626158d6af8ef4b58d67f97',
  })

  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'openssl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "TMPDIR=#{CREW_PREFIX}/tmp make check"
  end
end
