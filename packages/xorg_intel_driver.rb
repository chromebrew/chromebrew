require 'package'

class Xorg_intel_driver < Package
  description 'The Xorg Intel Driver package contains the X.Org Video Driver for Intel integrated video chips including 8xx, 9xx, Gxx, Qxx, HD, Iris, and Iris Pro graphics processors.'
  homepage 'https://01.org/linuxgraphics/'
  version '3.3.17'
  source_url 'https://github.com/endlessm/xf86-video-intel/archive/Release_3.3.17.tar.gz'
  source_sha256 'a2de40b68fd1edc9b30fe364d6e7f2f5765834a519c75b42eeac568b3fa2c900'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_intel_driver-3.3.17-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_intel_driver-3.3.17-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: 'cde6829f4369ebcc687ce8d8ca4bf13c22c815edb086bf7cd0cdd20cb42be1b1',
     x86_64: 'a9c50a31933fba36b7e3440b897b52cb18c2e264b8ac86aa2253e0cb899cb2a3',
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
