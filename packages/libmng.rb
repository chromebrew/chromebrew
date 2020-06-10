require 'package'

class Libmng < Package
  description 'A PNG-like Image Format Supporting Multiple Images, Animation and Transparent JPEG'
  homepage 'http://www.libpng.org/pub/mng/'
  version '2.0.3'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/libmng/libmng-devel/2.0.3/libmng-2.0.3.tar.xz'
  source_sha256 '4a462fdd48d4bc82c1d7a21106c8a18b62f8cc0042454323058e6da0dbb57dd3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmng-2.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmng-2.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmng-2.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmng-2.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b940238dbe081af502bee237e1eeaea7322732433146ace0ff45c0cf07665552',
     armv7l: 'b940238dbe081af502bee237e1eeaea7322732433146ace0ff45c0cf07665552',
       i686: '47fcd3230b379554ab8285b8ed92098fd9f34ae5df96ad92cf6cbe232abac090',
     x86_64: 'e8ffaa0dc0a372a93f04f9197872e2fd18675f21651a3632222ebfe8e21f4b6c',
  })

  depends_on 'lcms'
  depends_on 'libjpeg'

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
