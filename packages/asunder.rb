require 'buildsystems/autotools'

class Asunder < Autotools
  description 'a graphical CD ripper and encoder'
  homepage 'http://littlesvr.ca/asunder/'
  version '3.0.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "http://littlesvr.ca/asunder/releases/asunder-#{version}.tar.bz2"
  source_sha256 'b71341d746ccf56aa77b1785c6af81aa641d084ac3d34b78beb537618848b64b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59b1a498fa0cd809eb531a2cd8fce01c323dcedcc8abc87e87b6e3bfc044f455',
     armv7l: '59b1a498fa0cd809eb531a2cd8fce01c323dcedcc8abc87e87b6e3bfc044f455',
     x86_64: 'b7451454d0433777a136316614c9bc76cb7179757f74f5d2f4eacaf285758139'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'cdparanoia'
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk2'
  depends_on 'harfbuzz' # R
  depends_on 'libcddb'
  depends_on 'pango' # R
end
