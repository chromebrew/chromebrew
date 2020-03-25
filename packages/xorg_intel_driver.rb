require 'package'

class Xorg_intel_driver < Package
  description 'The Xorg Intel Driver package contains the X.Org Video Driver for Intel integrated video chips including 8xx, 9xx, Gxx, Qxx, HD, Iris, and Iris Pro graphics processors.'
  homepage 'https://01.org/linuxgraphics/'
  version '3.7.8'
  source_url 'https://github.com/endlessm/xf86-video-intel/archive/Release_3.7.8.tar.gz'
  source_sha256 '411d644cba1a46e9fd8143a969edc70a67ae18f15bba333f24ed8b87716f93fe'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xorg_server' => :build
  
  def self.build
    system "./autogen.sh"
    system "./configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--enable-shared",
             "--disable-static",
             "--enable-kms-only",
             "--enable-uxa"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end
end
