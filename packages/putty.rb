require 'buildsystems/cmake'

class Putty < CMake
  description 'Free Telnet, SSH, and Rlogin clients plus a terminal emulator'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/putty/'
  version '0.80'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://the.earth.li/~sgtatham/putty/latest/putty-0.80.tar.gz'
  source_sha256 '2013c83a721b1753529e9090f7c3830e8fe4c80a070ccce764539badb3f67081'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/putty/0.80_armv7l/putty-0.80-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/putty/0.80_armv7l/putty-0.80-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/putty/0.80_x86_64/putty-0.80-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f912d682a591e77d835f97caab122d83adaf63c3440c73972402a2a09f335e3a',
     armv7l: 'f912d682a591e77d835f97caab122d83adaf63c3440c73972402a2a09f335e3a',
     x86_64: '63dbbbca5ec4caea00e1cf63a45cf2cf3a093f0525e48c890e59eac88d85ba9b'
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
  depends_on 'zlibpkg' # R
end
