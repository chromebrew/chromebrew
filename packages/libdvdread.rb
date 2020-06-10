require 'package'

class Libdvdread < Package
  description 'libdvdnav is a library that allows easy use of sophisticated DVD navigation features such as DVD menus, multiangle playback and even interactive DVD games.'
  homepage 'http://dvdnav.mplayerhq.hu/'
  version '6.0.1'
  compatibility 'all'
  source_url 'https://get.videolan.org/libdvdread/6.0.1/libdvdread-6.0.1.tar.bz2'
  source_sha256 '28ce4f0063883ca4d37dfd40a2f6685503d679bca7d88d58e04ee8112382d5bd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdvdread-6.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdvdread-6.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdvdread-6.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdvdread-6.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a724a51f746624dfe879dc0c1671efd28450f1b4138d1b80d7b38bf6d5f3be89',
     armv7l: 'a724a51f746624dfe879dc0c1671efd28450f1b4138d1b80d7b38bf6d5f3be89',
       i686: '0cb1b8a9de61a738e8ab53e8d08661a6ad111c4a56846a70551d212c496b3014',
     x86_64: '3b79746022d1a16a53c4bbe5f8cd98d4b21355dbabfeb2a38df2c043b26b282f',
  })

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
