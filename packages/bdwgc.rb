require 'buildsystems/cmake'

class Bdwgc < CMake
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collector'
  homepage 'https://www.hboehm.info/gc/'
  version '8.2.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ivmai/bdwgc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e123af98ab5cc027dd1ba32a9fc1048a0bedf27dffb322ba0d5ae711d08ec70',
     armv7l: '2e123af98ab5cc027dd1ba32a9fc1048a0bedf27dffb322ba0d5ae711d08ec70',
       i686: 'f277512c24c20ea65a55d51410ac40453aab42d349672e5425a217009e040ac0',
     x86_64: '14f9a975ae17a0cde462794a1df8e30570807f51c5876bc32c24c51e4d7c12b9'
  })

  depends_on 'glibc' # R
end
