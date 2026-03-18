require 'buildsystems/cmake'

class Pocl < CMake
  description 'PoCL is a portable open source (MIT-licensed) implementation of the OpenCL standard.'
  homepage 'https://portablecl.org/'
  version '7.1'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/pocl/pocl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: 'ca5034ff4857842753dd3002bee4bf5476e19788c207b74e2cf2e0fea8782cb4'
  })

  depends_on 'cmake' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'hwloc' # R
  depends_on 'llvm_dev' # R
  depends_on 'llvm_lib' # R
  depends_on 'spirv_llvm_translator' # R
  depends_on 'spirv_tools' # R

  cmake_options '-DLLC_HOST_CPU=x86-64'

  def self.postinstall
    ExitMessage.add "\nType 'poclcc -h' to get started.\n"
  end
end
