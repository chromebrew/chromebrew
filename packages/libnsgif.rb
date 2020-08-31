require 'package'

class Libnsgif < Package
  description 'Decoding library for the GIF image file format, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.2.1'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libnsgif-0.2.1-src.tar.gz'
  source_sha256 '9eaea534cd70b53c5aaf45317ae957701685a6b4a88dbe34ed26f4faae879a4b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnsgif-0.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnsgif-0.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnsgif-0.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnsgif-0.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd5157c5ebd4efe5049238558b3613306d2c8390bcf52a5c09b0132a225890756',
     armv7l: 'd5157c5ebd4efe5049238558b3613306d2c8390bcf52a5c09b0132a225890756',
       i686: '2021197bd230a09a34bb9a8c32a2b346e87850cc5ae738ac10a616f0833f6d94',
     x86_64: '41bfd7be6e7742e100579977829b2eb09ad26ebb204609ea438422357fa9d02c',
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
