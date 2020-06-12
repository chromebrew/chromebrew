require 'package'

class Slang < Package
  description 'S-Lang is a multi-platform programmer\'s library designed to allow a developer to create robust multi-platform software.'
  homepage 'http://www.jedsoft.org/slang/'
  version '2.3.2'
  compatibility 'all'
  source_url 'https://www.jedsoft.org/releases/slang/slang-2.3.2.tar.bz2'
  source_sha256 'fc9e3b0fc4f67c3c1f6d43c90c16a5c42d117b8e28457c5b46831b8b5d3ae31a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/slang-2.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/slang-2.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/slang-2.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/slang-2.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c957e37812aadaecea026ef184729f1892fe5a24a843bc0b28fc0ee322855e87',
     armv7l: 'c957e37812aadaecea026ef184729f1892fe5a24a843bc0b28fc0ee322855e87',
       i686: '8fa398bb8d47a423eac2a687c16a409c671342edaa6bb1afeeceac440c0459ca',
     x86_64: '6d7968b8a251a184c06d96e0466c9c7fabae9033c7be9ad9fc4b2b60816eaa37',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-x'

    # force to compile in sequential since slang Makefile doesn't work in parallel
    system "make", "-j1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
