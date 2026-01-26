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
    aarch64: 'dee5b19970f6164ba466095ff6b7fedbe8305640d4d2cf7e65b99e7b8c6754e0',
     armv7l: 'dee5b19970f6164ba466095ff6b7fedbe8305640d4d2cf7e65b99e7b8c6754e0',
     x86_64: 'fa5f7fda1606274071329f43de7966f90cb400178dba006600e34780b4390c1d'
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
