require 'buildsystems/cmake'

class Bdwgc < CMake
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collector'
  homepage 'https://www.hboehm.info/gc/'
  version '8.2.10'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ivmai/bdwgc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '731469a0cb3d82a3c9dddfc0606a267655b8b87340e84727d014917e1d2131e1',
     armv7l: '731469a0cb3d82a3c9dddfc0606a267655b8b87340e84727d014917e1d2131e1',
       i686: 'a0e9420c8936fc93080f023d24305a99b509e33d050ad83926f52f9d363ea368',
     x86_64: '0adac7d4b9c52fbf4bb8a133d835c830d53a40c162cfe04050aadec779588724'
  })

  depends_on 'glibc' # R
end
