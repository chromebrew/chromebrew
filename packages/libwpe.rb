require 'package'

class Libwpe < Package
  description 'General-purpose library specifically developed for the WPE-flavored port of WebKit.'
  homepage 'https://github.com/WebPlatformForEmbedded/libwpe'
  version '1.6.0'
  compatibility 'all'
  source_url 'https://github.com/WebPlatformForEmbedded/libwpe/releases/download/1.6.0/libwpe-1.6.0.tar.xz'
  source_sha256 '3587c6b8a807f4bb76b268ba74ca82c6b395b90235db41ad8252224456193c90'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83424c5f20ccc168be9bcf8dfdebb38486b6bac3984575f9c021b71c93feee10',
     armv7l: '83424c5f20ccc168be9bcf8dfdebb38486b6bac3984575f9c021b71c93feee10',
       i686: '597a643c854cc2a6fba391d47adacb4f9d1d77dd1445981c03aedc6818903756',
     x86_64: '9c258f03e8f7861cbf990b6585687b7f3a150782854abccf1bc2768e14c26991',
  })

  depends_on 'libxkbcommon'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
