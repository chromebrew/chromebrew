require 'buildsystems/cmake'

class Openal < CMake
  description 'OpenAL Soft is a software implementation of the cross-platform OpenAL 3D audio API appropriate for use with gaming applications and many other types of audio applications.'
  homepage 'https://openal-soft.org/'
  version '1.25.2'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/kcat/openal-soft.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63351134317170cb9b15988446ac9f597432cce0dcfcb7e29651aad0b4ffd7a9',
     armv7l: '63351134317170cb9b15988446ac9f597432cce0dcfcb7e29651aad0b4ffd7a9',
     x86_64: 'dd812c46f43e11379d361163f3b6393b9fbd69c9fd879d6e4270f4a2bae8205a'
  })

  depends_on 'alsa_lib' => :build
  depends_on 'dbus' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jack' => :build
  depends_on 'libmysofa' => :executable
  depends_on 'libsndfile' => :build
  depends_on 'pipewire' => :build
  depends_on 'portaudio' => :build
  depends_on 'pulseaudio' => :build

  cmake_options '-DALSOFT_EXAMPLES=OFF'
end
