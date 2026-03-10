require 'buildsystems/cmake'

class Openal < CMake
  description 'OpenAL Soft is a software implementation of the cross-platform OpenAL 3D audio API appropriate for use with gaming applications and many other types of audio applications.'
  homepage 'https://openal-soft.org/'
  version '1.25.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/kcat/openal-soft.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '66eb40c326b54b67dcdbf8402339041050fd78cc5959ab51d84fac7128663a77',
     armv7l: '66eb40c326b54b67dcdbf8402339041050fd78cc5959ab51d84fac7128663a77',
     x86_64: '737074c8055fa50957e66e7ba4724dbef67f544b45a0a6c38342c31141e981f2'
  })

  depends_on 'alsa_lib'
  depends_on 'dbus'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jack'
  depends_on 'libmysofa'
  depends_on 'libmysofa' => :executable_only
  depends_on 'libsndfile'
  depends_on 'pipewire'
  depends_on 'portaudio'
  depends_on 'pulseaudio'

  cmake_options '-DALSOFT_EXAMPLES=OFF'
end
