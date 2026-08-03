require 'buildsystems/cmake'

class Nanomsg < CMake
  description 'nanomsg is a socket library that provides several common communication patterns.'
  homepage 'https://nanomsg.org/'
  version '1.2.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nanomsg/nanomsg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f303e1122520c63f361a638f79a1d983dc430b209cad0b761319811f86b0505e',
     armv7l: 'f303e1122520c63f361a638f79a1d983dc430b209cad0b761319811f86b0505e',
       i686: '98763f7e9507d4506b506d0652fb921db099b620b76c25b5bb8481a4852ba64e',
     x86_64: '03690b2fa1a8cd256b851ed960193965d66d85637312538bbf710b94f297f16f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  run_tests
end
