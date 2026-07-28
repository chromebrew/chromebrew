require 'buildsystems/cmake'

class Putty < CMake
  description 'Free Telnet, SSH, and Rlogin clients plus a terminal emulator'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/putty/'
  version '0.84'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://the.earth.li/~sgtatham/putty/latest/putty-#{version}.tar.gz"
  source_sha256 '06057862ae198f1dbd219d0c7493080d59f606194bb5056c549e342aa01b69fe'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0eb7c7cef781a2a7b1f0fc0f9e47a3e58b86609698c048049483fe9527516a5e',
     armv7l: '0eb7c7cef781a2a7b1f0fc0f9e47a3e58b86609698c048049483fe9527516a5e',
     x86_64: '580c0439c5767e8e79a5d88b9bdfb0b6ce30b77f562eddf70994ac976c65a8d8'
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
