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
       i686: 'cc156e80692820cbaa2bf816cd6da3b699e0bae35af228d64d639365e8346dcd',
     x86_64: '9a59dfe1ce9e60dfdb5936ec5b8fb0b5d6d060f5f1d137141b93798a951359ac',
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
