require 'package'

class Libfdk_aac < Package
  description 'Modified library of Fraunhofer AAC decoder and encoder.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '2.0.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-2.0.1.tar.gz'
  source_sha256 '840133aa9412153894af03b27b03dde1188772442c316a4ce2a24ed70093f271'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfdk_aac-2.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfdk_aac-2.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfdk_aac-2.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfdk_aac-2.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '08f675d0b53219ef822e7eee420c80b92ef017e15e198bee44554cbe7e77b6e0',
     armv7l: '08f675d0b53219ef822e7eee420c80b92ef017e15e198bee44554cbe7e77b6e0',
       i686: 'bb0205bc24b0e5700e3d267d3de6b0cf546089a369ed0813cffa31f101da32a5',
     x86_64: '9a254d4f55e4cc653aa1168b23eac55e2182b8131dcf1b94c7ea4cc3f85d4897',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--enable-shared'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
