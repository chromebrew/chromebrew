require 'buildsystems/cmake'

class Nanomsg < CMake
  description 'nanomsg is a socket library that provides several common communication patterns.'
  homepage 'https://nanomsg.org/'
  version '1.3.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nanomsg/nanomsg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eef5daec2567950121ef5d4c935b0f75f0f7f5a5e8901a35796ba09c8fb56f98',
     armv7l: 'eef5daec2567950121ef5d4c935b0f75f0f7f5a5e8901a35796ba09c8fb56f98',
       i686: 'c45bb4cb53a3424228172c9616998de0e80dc6eea59d6a79be800806144e639d',
     x86_64: '617d5523ac1e20a22cd0bd67d2410a27aaebd2b62acca9299abb40f516adc616'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  run_tests
end
