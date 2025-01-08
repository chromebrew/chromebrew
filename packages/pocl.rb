require 'buildsystems/cmake'

class Pocl < CMake
  description 'PoCL is a portable open source (MIT-licensed) implementation of the OpenCL standard.'
  homepage 'https://portablecl.org/'
  version '6.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/pocl/pocl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '233188364ce93b7cd95c273c728fee947b2a6ef4d376825a65b08484d7eb74ba'
  })

  depends_on 'cmake' => :build
  # llvm version between 14.0 and 18.0 required to build.
  # llvm19+ must be removed to avoid detection.
  depends_on 'llvm18_dev' => :build
  depends_on 'llvm18_lib' => :build
  depends_on 'hwloc'

  cmake_options '-DLLC_HOST_CPU=x86-64'

  def self.postinstall
    ExitMessage.add "\nType 'poclcc -h' to get started.\n"
  end
end
