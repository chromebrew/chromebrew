require 'buildsystems/autotools'

class Libx11 < Autotools
  description 'C interface to the X window system'
  homepage 'https://x.org/wiki/'
  version '1.8.12'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d9aacc2ecc3e54fa78057498456e235304c4f11f2e834d4120961b69070b0ea',
     armv7l: '9d9aacc2ecc3e54fa78057498456e235304c4f11f2e834d4120961b69070b0ea',
     x86_64: '472ca926ca8cf52d5ee45b609c329e955630920a8116663d25d1dc38cf649c33'
  })

  depends_on 'glibc' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxtrans' => :build
  depends_on 'llvm_lib' => :build
  depends_on 'xorg_proto' => :build

end
