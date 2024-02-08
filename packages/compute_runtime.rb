# Adapted from Arch Linux compute-runtime PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=compute-runtime

require 'buildsystems/cmake'

class Compute_runtime < CMake
  description 'IntelR Graphics Compute Runtime for OpenCLTM. Replaces Beignet for Gen8 Broadwell and beyond. Weekly build version.'
  homepage 'https://01.org/compute-runtime'
  version '23.52.28202.14'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/intel/compute-runtime.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '222'
  })

  depends_on 'intel_graphics_compiler' => :build
  depends_on 'intel_opencl_clang' => :build
  depends_on 'llvm17_dev' => :build
  depends_on 'vc_intrinsics' => :build
end
