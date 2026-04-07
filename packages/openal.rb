require 'buildsystems/cmake'

class Openal < CMake
  description 'OpenAL Soft is a software implementation of the cross-platform OpenAL 3D audio API appropriate for use with gaming applications and many other types of audio applications.'
  homepage 'https://openal-soft.org/'
  version '1.25.1'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/kcat/openal-soft.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '66eb40c326b54b67dcdbf8402339041050fd78cc5959ab51d84fac7128663a77',
     armv7l: '66eb40c326b54b67dcdbf8402339041050fd78cc5959ab51d84fac7128663a77',
     x86_64: '737074c8055fa50957e66e7ba4724dbef67f544b45a0a6c38342c31141e981f2'
  })

  depends_on 'alsa_lib' => :build
  depends_on 'dbus' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'jack' => :build
  depends_on 'libmysofa' => :executable
  depends_on 'libsndfile' => :build
  depends_on 'pipewire' => :build
  depends_on 'portaudio' => :build
  depends_on 'pulseaudio' => :build

  cmake_options '-DALSOFT_EXAMPLES=OFF'
end
