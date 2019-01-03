require 'package'

class Twm < Package
  description 'The twm package contains a very minimal window manager.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/x/twm.html'
  version '1.0.10'
  source_url 'https://www.x.org/pub/individual/app/twm-1.0.10.tar.bz2'
  source_sha256 '6449eadca16ce0f0d900605b0cc020b95f40619261b7beccfb46bcc1836445d7'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xorg_server'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
