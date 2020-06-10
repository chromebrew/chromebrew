require 'package'

class Libdvdnav < Package
  description 'libdvdnav is a library that allows easy use of sophisticated DVD navigation features such as DVD menus, multiangle playback and even interactive DVD games.'
  homepage 'http://dvdnav.mplayerhq.hu/'
  version '6.0.0'
  compatibility 'all'
  source_url 'http://get.videolan.org/libdvdnav/6.0.0/libdvdnav-6.0.0.tar.bz2'
  source_sha256 'f0a2711b08a021759792f8eb14bb82ff8a3c929bf88c33b64ffcddaa27935618'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdvdnav-6.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdvdnav-6.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdvdnav-6.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdvdnav-6.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '72938f6813add62c1be036f36cd33e6e3dceeec5255818e8b9c9031ba86cb457',
     armv7l: '72938f6813add62c1be036f36cd33e6e3dceeec5255818e8b9c9031ba86cb457',
       i686: '82b4c2028f58bc5064099b4e43a25f32f96f71e0db859613d11c76e18b3f4e1b',
     x86_64: '6aa51f0f8864f54e106821bdb8aca9466c083b2fde2cb27163e72ef2ed096d70',
  })

  depends_on 'libdvdread'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
