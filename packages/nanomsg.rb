require 'buildsystems/cmake'

class Nanomsg < CMake
  description 'nanomsg is a socket library that provides several common communication patterns.'
  homepage 'https://nanomsg.org/'
  version '1.2.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nanomsg/nanomsg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ae948550c1e89b5f7428206ba532762866cbd0d4846b473cb7d04faa33e40f6',
     armv7l: '3ae948550c1e89b5f7428206ba532762866cbd0d4846b473cb7d04faa33e40f6',
       i686: 'a83453df24247af3c5556eb97c2d4f9e8e89cc8cec450c77e34937609947a13f',
     x86_64: '04175387ed5c0882622f512794aec327cc4cc41094d2ca3a4c74c5565e1c5968'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  run_tests
end
