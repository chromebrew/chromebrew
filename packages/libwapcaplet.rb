require 'package'

class Libwapcaplet < Package
  description 'String internment library, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.4.3'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libwapcaplet-0.4.3-src.tar.gz'
  source_sha256 '9b2aa1dd6d6645f8e992b3697fdbd87f0c0e1da5721fa54ed29b484d13160c5c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwapcaplet-0.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwapcaplet-0.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwapcaplet-0.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwapcaplet-0.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '47d15b3284af74ebadf763f6640f440461e096b070bb5f8e3c69cc3ffda03763',
     armv7l: '47d15b3284af74ebadf763f6640f440461e096b070bb5f8e3c69cc3ffda03763',
       i686: '3b621c7937f5b69a7875d611ec6cd441c65764432af794d9b8c942b5c250c07a',
     x86_64: '44bd2c72b15c9d059b51b4dc598fd5b9044b12a10ca55b0dfc561b1d71e36073',
  })
  
  depends_on 'netsurf_buildsystem' => :build

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
