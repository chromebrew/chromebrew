require 'buildsystems/cmake'

class Putty < CMake
  description 'Free Telnet, SSH, and Rlogin clients plus a terminal emulator'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/putty/'
  version '0.85'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://the.earth.li/~sgtatham/putty/latest/putty-#{version}.tar.gz"
  source_sha256 '13fd4db2936d03b73812a7bcc2a658e4dd29cc776a56c3670a7fc6f1a0ee8af8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68586fd5a21a0cd25011399347f1b98c1357b3fd2c8340df6d2f0c674cc32c90',
     armv7l: '68586fd5a21a0cd25011399347f1b98c1357b3fd2c8340df6d2f0c674cc32c90',
     x86_64: '5d8a844e59954df97524d570b8ba138ad542bff8e228b9eb2443c2c4ce2d585e'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libice' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxrender' => :executable
  depends_on 'pango' => :executable
  depends_on 'zlib' => :executable
end
