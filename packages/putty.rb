require 'buildsystems/cmake'

class Putty < CMake
  description 'Free Telnet, SSH, and Rlogin clients plus a terminal emulator'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/putty/'
  version '0.83'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://the.earth.li/~sgtatham/putty/latest/putty-#{version}.tar.gz"
  source_sha256 '195621638bb6b33784b4e96cdc296f332991b5244968dc623521c3703097b5d9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f03651b884611a0e05cd27ce90777a015c4ec6ed10e1a6fb2799062469fa68fb',
     armv7l: 'f03651b884611a0e05cd27ce90777a015c4ec6ed10e1a6fb2799062469fa68fb',
     x86_64: '587331f06ea9fee7cf8199687178e18dcbdacecdc33c4fbd7d47f8e47c06e6d9'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'pango' # R
  depends_on 'zlib' # R
end
