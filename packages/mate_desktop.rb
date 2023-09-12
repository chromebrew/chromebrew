require 'buildsystems/autotools'

class Mate_desktop < Autotools
  description 'Libraries for the MATE desktop that are not part of the UI.'
  homepage 'https://mate-desktop.org'
  version '1.27.2'
  license 'FDL-1.1, GPL-2+, LGPL-2+, MIT-with-advertising'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://pub.mate-desktop.org/releases/#{version.rpartition('.')[0]}/mate-desktop-#{version}.tar.xz"
  source_sha256 'ec3b6f3668026f933e033714daf858387c3e8d9fa46202c3d74deefe5f7b8be7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mate_desktop/1.27.2_armv7l/mate_desktop-1.27.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mate_desktop/1.27.2_armv7l/mate_desktop-1.27.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mate_desktop/1.27.2_x86_64/mate_desktop-1.27.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2bdbf679155c30c044907e476972129fa042e7d6125532a964b358a097bb4e5a',
     armv7l: '2bdbf679155c30c044907e476972129fa042e7d6125532a964b358a097bb4e5a',
     x86_64: '8c1186ba9c092ccf3c8fc36863b4dd8b60ff3c96ff3e8d546c1c43aa2ac55b07'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'iso_codes' => :build
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'mate_common' => :build
  depends_on 'pango' # R
  depends_on 'zlibpkg' # R
end
