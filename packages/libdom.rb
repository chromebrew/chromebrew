require 'package'

class Libdom < Package
  description 'Implementation of the W3C DOM, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.4.1'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libdom-0.4.1-src.tar.gz'
  source_sha256 '98ee072471e55e208c9878e515c410ad462ca36f87b4afcbecad023f3a2cef4a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdom-0.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdom-0.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdom-0.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdom-0.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7fa6e8636c79092311db986438b9234bd2c5ec9a8d66081ad13c87f49048ac70',
     armv7l: '7fa6e8636c79092311db986438b9234bd2c5ec9a8d66081ad13c87f49048ac70',
       i686: '4a646fac2a67a2129096e873c04adeed05a95cf55c08f7a24d30ee70c86fe48c',
     x86_64: 'adb310321694c02e68faf7f4ba97e54903b5c6e132a7a29564ec590bab9269c0',
  })

  depends_on 'expat'
  depends_on 'libparserutils'
  depends_on 'libwapcaplet'
  depends_on 'libhubbub'

  def self.build
    system "make PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared"
  end

  def self.install
    system "make install PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared DESTDIR=#{CREW_DEST_DIR}"
    case ARCH
    when 'x86_64'
      Dir.chdir CREW_DEST_PREFIX do
        FileUtils.mv 'lib/', 'lib64/'
      end
    end
  end
end
