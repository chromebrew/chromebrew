require 'buildsystems/autotools'

class Vice < Autotools
  description 'Emulates the C64, the C64DTV, the C128, the VIC20, practically all PET models, the PLUS4 and the CBM-II (aka C610/C510).'
  homepage 'https://vice-emu.sourceforge.io/'
  version '3.8'
  license 'GPL-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/vice-emu/releases/vice-3.8.tar.gz'
  source_sha256 '1d7dc4d0f2bbcc2a871bb954ff4a5df63048dea9c16f5f1e9bc8260fa41a1004'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vice/3.8_armv7l/vice-3.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vice/3.8_armv7l/vice-3.8-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vice/3.8_x86_64/vice-3.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '58560b5fa3bdde6e667fd7bc074bdd84bfa6bd63c65d1c08a9cc2700daf991ae',
     armv7l: '58560b5fa3bdde6e667fd7bc074bdd84bfa6bd63c65d1c08a9cc2700daf991ae',
     x86_64: 'aecc034b2a47d201b9da2bb7566dbf1777eb697bd943fa75beb76918c466e4fc'
  })

  depends_on 'dos2unix' => :build
  depends_on 'xa' => :build
  depends_on 'curl' # R
  depends_on 'flac' # R
  depends_on 'fontconfig' # R
  depends_on 'glew' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'icoutils' # R
  depends_on 'libiconv' # R
  depends_on 'mpg123' # R
  depends_on 'pulseaudio' # R
  depends_on 'xdg_utils' # R
  depends_on 'zlibpkg' # R

  configure_options '--enable-gtk3ui \
    --enable-desktop-files \
    --with-flac \
    --with-mpg123'
end
