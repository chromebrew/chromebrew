
require 'package'

class Xkeyboard_config < Package
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'http://www.freedesktop.org/wiki/Software/XKeyboardConfig'
  version '2.29'
  source_url 'https://www.x.org/releases/individual/data/xkeyboard-config/xkeyboard-config-2.29.tar.bz2'
  source_sha256 '1d4175278bf06000683656763a8b1d3282c61a314b6db41260c8efe92d621802'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xkeyboard_config-2.29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xkeyboard_config-2.29-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xkeyboard_config-2.29-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xkeyboard_config-2.29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'eae7e1d93e5ad45040b4f98f641d9710c5815bc753fabb0e51d781eeb45785bc',
     armv7l: 'eae7e1d93e5ad45040b4f98f641d9710c5815bc753fabb0e51d781eeb45785bc',
       i686: '545e4eecd93f68f3aa6626933e082db6bb65889f68f9b47bf0d343d9a6b53cb7',
     x86_64: 'a3d3467cbc60baa18a8f41585103ad440cff1461c835b895c82e5f51f4f34382',
  })

  depends_on 'libx11'

  def self.build
    system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,' ./rules/compat/map-variants.py"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

end
