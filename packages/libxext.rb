require 'buildsystems/autotools'

class Libxext < Autotools
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '1.3.7'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxext.git'
  git_hashtag "libXext-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62e7c72360e9ef01f3653a803cb69d49d8c075ffcd0889751829135deb6b5009',
     armv7l: '62e7c72360e9ef01f3653a803cb69d49d8c075ffcd0889751829135deb6b5009',
     x86_64: 'f1284ee9e7b256da531edad962a014302d6d627d8beb60a30af5cd6c751d1a34'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'llvm_lib' => :build
  depends_on 'xmlto' => :build

  run_tests
end
