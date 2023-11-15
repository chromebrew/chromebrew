require 'buildsystems/cmake'

class Putty < CMake
  description 'Free Telnet, SSH, and Rlogin clients plus a terminal emulator'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/putty/'
  version '0.79'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://the.earth.li/~sgtatham/putty/latest/putty-0.79.tar.gz'
  source_sha256 '428cc8666fbb938ebf4ac9276341980dcd70de395b33164496cf7995ef0ef0d8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/putty/0.79_armv7l/putty-0.79-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/putty/0.79_armv7l/putty-0.79-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/putty/0.79_x86_64/putty-0.79-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5c0134296695b1aad7631fbc2357dad7f218b84d934adf2f581d99ad6ce4a662',
     armv7l: '5c0134296695b1aad7631fbc2357dad7f218b84d934adf2f581d99ad6ce4a662',
     x86_64: '4c2849c1a4ffe3f6f910471ef491db63db27a374392c53c176ef412c33febaf3'
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
