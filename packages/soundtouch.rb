require 'buildsystems/cmake'

class Soundtouch < CMake
  description 'SoundTouch is an open-source audio processing library for changing the Tempo, Pitch and Playback Rates of audio streams or audio files.'
  homepage 'https://www.surina.net/soundtouch/'
  version '2.4.1'
  license 'LGPL v2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://codeberg.org/soundtouch/soundtouch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f8d7b76292b46784831de3c99dfb561f8aa65875cbeefab0b6cf62b76fcc292',
     armv7l: '5f8d7b76292b46784831de3c99dfb561f8aa65875cbeefab0b6cf62b76fcc292',
     x86_64: 'debe72a3bdadf2dd4c673cb20b8b05c03fb261ffb237fce6ba62237b92d2ec97'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
