require 'buildsystems/autotools'

class Libx11 < Autotools
  description 'C interface to the X window system'
  homepage 'https://x.org/wiki/'
  version '1.8.12'
  license 'X11'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d9aacc2ecc3e54fa78057498456e235304c4f11f2e834d4120961b69070b0ea',
     armv7l: '9d9aacc2ecc3e54fa78057498456e235304c4f11f2e834d4120961b69070b0ea',
       i686: '906d6c0eb0d44d46ce4c9a80d21a09b63adb4bf43a9ea04aeb6b1a1f576b0f03',
     x86_64: '472ca926ca8cf52d5ee45b609c329e955630920a8116663d25d1dc38cf649c33'
  })

  depends_on 'glibc' => :library
  depends_on 'libbsd' => :library
  depends_on 'libxau' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxdmcp' => :library
  depends_on 'libxtrans' => :build
  depends_on 'llvm_lib' => :build
  depends_on 'xorg_proto' => :build
end
