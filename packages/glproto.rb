require 'package'

class Glproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.4.17-0'
  source_url 'https://www.x.org/archive/individual/proto/glproto-1.4.17.tar.gz'
  source_sha256 '9d8130fec2b98bd032db7730fa092dd9dec39f3de34f4bb03ceb43b9903dbc96'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: 'f4838cf8326d49489449651621089b41cbd272a662080c37689d185f69dbf6c2',
     armv7l: 'f4838cf8326d49489449651621089b41cbd272a662080c37689d185f69dbf6c2',
       i686: '3957ebb8e93b706662ccf4e90c02695ad393bbda09b00d5263e05f4335b51fd7',
     x86_64: 'df88d08e93501957db16bbbcf24a8627fb706fce19b6718dbda4803d74a95055',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
