require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.5.1'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.1.tar.xz'
  source_sha256 '886ac5eed41e3b5fc699be837b0087a6a5a3d10f464087560d2d21b3e71b754d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b03154f57e2599f71b0bdd42ba3a126397eca451ccb99485615b5b0429955152',
     armv7l: 'b03154f57e2599f71b0bdd42ba3a126397eca451ccb99485615b5b0429955152',
       i686: 'de1d30b89fd09b6e544fe537cbbc4cdc76f4f1610b0f801ab82ce90c1dc04999',
     x86_64: '2e60c9b84968f17ac796e92992a5e32b4c39291d5a0b1bb0183f43d1c784303f',
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
    system "TMPDIR=#{CREW_PREFIX}tmp make check"
  end
end
