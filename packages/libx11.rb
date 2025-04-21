require 'buildsystems/autotools'

class Libx11 < Autotools
  description 'C interface to the X window system'
  homepage 'https://x.org/wiki/'
  version '1.8.10'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e992951cf49ed047e4ef45e45b87b640e5aafed4a0614543d7c6957613dd463',
     armv7l: '3e992951cf49ed047e4ef45e45b87b640e5aafed4a0614543d7c6957613dd463',
     x86_64: '55c2d33cc673cec976f9f628204da0f02e83a92aae0936a42a231df81d5dd05c'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxtrans' => :build
  depends_on 'llvm_lib' => :build
  depends_on 'xorg_proto' => :build
end
