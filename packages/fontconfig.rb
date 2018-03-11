require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  version '2.13.0'
  source_url 'https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.0.tar.gz'
  source_sha256 'a6ca290637d8b2c4e1dd40549b179202977593f7481ec83ddfb1765ad90037ba'

  binary_url ({

  })
  binary_sha256 ({

  })

  depends_on 'expat'
  depends_on 'gperf'
  depends_on 'pkgconfig'
  depends_on 'freetype'

  def self.build
    system "./configure \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX} \
          --localstatedir=#{CREW_PREFIX}/cache"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
