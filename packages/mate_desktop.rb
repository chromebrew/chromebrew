require 'buildsystems/autotools'

class Mate_desktop < Autotools
  description 'Libraries for the MATE desktop that are not part of the UI.'
  homepage 'https://mate-desktop.org'
  version '1.28.2'
  license 'FDL-1.1, GPL-2+, LGPL-2+, MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pub.mate-desktop.org/releases/#{version.rpartition('.')[0]}/mate-desktop-#{version}.tar.xz"
  source_sha256 '32bb4b792014b391c1e1b8ae9c18a82b4d447650984b4cba7d28e95564964aa2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60bcbd984b839b11057aa2d0e249e94a50aecefba241b4c4df1c1405c24ab53a',
     armv7l: '60bcbd984b839b11057aa2d0e249e94a50aecefba241b4c4df1c1405c24ab53a',
     x86_64: 'cf5461b6ad3704db111d5ffe37e29c75764359f3a0b101788c4a72a39f1da69b'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'iso_codes' => :build
  depends_on 'libbsd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxrandr' # R
  depends_on 'mate_common' => :build
  depends_on 'pango' # R
  depends_on 'zlib' # R
end
