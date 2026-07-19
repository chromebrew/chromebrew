require 'buildsystems/autotools'

class Libxext < Autotools
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '1.3.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxext.git'
  git_hashtag "libXext-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dee5b19970f6164ba466095ff6b7fedbe8305640d4d2cf7e65b99e7b8c6754e0',
     armv7l: 'dee5b19970f6164ba466095ff6b7fedbe8305640d4d2cf7e65b99e7b8c6754e0',
       i686: '6f08dbce3068f6f8b109ba817490a959829247de777eac000807ba6ca1855eea',
     x86_64: 'fa5f7fda1606274071329f43de7966f90cb400178dba006600e34780b4390c1d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxdmcp' => :library
  depends_on 'llvm_lib' => :build
  depends_on 'xmlto' => :build

  run_tests
end
