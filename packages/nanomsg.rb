require 'buildsystems/cmake'

class Nanomsg < CMake
  description 'nanomsg is a socket library that provides several common communication patterns.'
  homepage 'https://nanomsg.org/'
  version '1.2.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nanomsg/nanomsg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0574fed9601c7b17920ef3e3e97d1f2839361aafede3b97db7c6ab52a5b38d7e',
     armv7l: '0574fed9601c7b17920ef3e3e97d1f2839361aafede3b97db7c6ab52a5b38d7e',
       i686: '81991c7c7b63700537930a6a29954e5382a3cb5a5b4c58af398a626cc2af5b7e',
     x86_64: '1d2169dd46a8691c3d7010ec92f5e3e1780baa8e2768746ad328af3738943632'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  run_tests
end
