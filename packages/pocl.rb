require 'buildsystems/cmake'

class Pocl < CMake
  description 'PoCL is a portable open source (MIT-licensed) implementation of the OpenCL standard.'
  homepage 'https://portablecl.org/'
  version '7.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pocl/pocl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'llvm21_dev'
  depends_on 'llvm21_lib'
  depends_on 'hwloc'

  def self.postinstall
    ExitMessage.add "\nType 'poclcc -h' to get started.\n"
  end
end
