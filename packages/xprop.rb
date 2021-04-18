require 'package'

class Xprop < Package
  description 'Xprop is a property displayer for X.'
  homepage 'https://www.x.org/'
  version '1.2.5'
  license 'MIT-with-advertising and ISC'
  compatibility 'all'
  source_url 'https://x.org/releases/individual/app/xprop-1.2.5.tar.bz2'
  source_sha256 '9b92ed0316bf2486121d8bac88bd1878f16b43bd335f18009b1f941f1eca93a1'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xprop-1.2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xprop-1.2.5-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/xprop-1.2.5-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/xprop-1.2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '67a59122be3f28942a9c2d8752ea09d9e4f854415f1512d1f2b2b90ead9d37a4',
     armv7l: '67a59122be3f28942a9c2d8752ea09d9e4f854415f1512d1f2b2b90ead9d37a4',
       i686: 'b5614aabe21d4a0c001a2c79e40ed898756a6a4d9cb76ea183f45a9b549fa84d',
     x86_64: '47d22d5a8bd02ce77b7ccc1955cf821e39c865e637598746a9ca7a38297f1c6f',
  })

  depends_on 'xorg_lib'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
