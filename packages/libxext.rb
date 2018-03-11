require 'package'

class Libxext < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.3.3-0'
  source_url 'https://www.x.org/archive/individual/lib/libXext-1.3.3.tar.gz'
  source_sha256 'eb0b88050491fef4716da4b06a4d92b4fc9e76f880d6310b2157df604342cfe5'

  binary_url ({

  })
  binary_sha256 ({

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
