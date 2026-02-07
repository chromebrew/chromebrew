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
    aarch64: '26e6ba88e571d39e66c64858ba3c85368bfa35ee2cc67eff2830f2c0c0961b20',
     armv7l: '26e6ba88e571d39e66c64858ba3c85368bfa35ee2cc67eff2830f2c0c0961b20',
     x86_64: '67bcd4d7f7f587af2e0b650f1eb55fd1f79d9fd1796250ec74059d2c296be4c1'
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
