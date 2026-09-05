require 'buildsystems/cmake'

class Pocl < CMake
  description 'PoCL is a portable open source (MIT-licensed) implementation of the OpenCL standard.'
  homepage 'https://portablecl.org/'
  version '7.2'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/pocl/pocl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'da552d0f56021da6e09a6156c9370dd962b44674e24509bb2fcee7929596fb15'
  })

  depends_on 'cmake' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'hwloc' => :library
  depends_on 'llvm_dev' => :library
  depends_on 'llvm_lib' => :library
  depends_on 'spirv_llvm_translator' => :library
  depends_on 'spirv_tools' # R

  cmake_options '-DLLC_HOST_CPU=x86-64'

  def self.postinstall
    ExitMessage.add "\nType 'poclcc -h' to get started.\n"
  end
end
