require 'buildsystems/cmake'

class Putty < CMake
  description 'Free Telnet, SSH, and Rlogin clients plus a terminal emulator'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/putty/'
  version '0.83'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://the.earth.li/~sgtatham/putty/latest/putty-#{version}.tar.gz"
  source_sha256 '195621638bb6b33784b4e96cdc296f332991b5244968dc623521c3703097b5d9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ecfe1d617d11768e210ecded8185711b57747c5e20408306090fd0d88b972364',
     armv7l: 'ecfe1d617d11768e210ecded8185711b57747c5e20408306090fd0d88b972364',
     x86_64: 'b66f3a1691b04d7ff87bad0f5c119bf754b1a64a07c914122d3ca33f5d8cbe25'
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
