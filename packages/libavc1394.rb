require 'package'

class Libavc1394 < Package
  description 'libavc1394 is a programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set.'
  homepage 'https://sourceforge.net/projects/libavc1394/'
  version '0.5.4'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libavc1394/libavc1394/libavc1394-0.5.4.tar.gz'
  source_sha256 '7cb1ff09506ae911ca9860bef4af08c2403f3e131f6c913a2cbd6ddca4215b53'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libavc1394-0.5.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libavc1394-0.5.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libavc1394-0.5.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libavc1394-0.5.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '57ba75e9dd0cf910ec946b83626e3266401fa02a8673301a65b46be17fc60426',
     armv7l: '57ba75e9dd0cf910ec946b83626e3266401fa02a8673301a65b46be17fc60426',
       i686: '4ad13321cd0cbb9e15dfe8bf6834e1e29c6436acda8fcff55c2112f3b278e55b',
     x86_64: '633edd7c131376ec1e76b8d4540fada425525f9f97d34107abe1a4cca7d45117',
  })

  depends_on 'libraw1394'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
