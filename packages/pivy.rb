require 'buildsystems/cmake'

class Pivy < CMake
  description 'python bindings to coin3d'
  homepage 'https://github.com/coin3d/pivy'
  version '0.6.11'
  license 'ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/coin3d/pivy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aae1bfe84b71b451be6a1c0ec0b392592e6e0eeb4aaa82dbdf69272ec846b053',
     armv7l: 'aae1bfe84b71b451be6a1c0ec0b392592e6e0eeb4aaa82dbdf69272ec846b053',
     x86_64: '40f5bd10bd037ac0707be2c5fc1e2f973389573fa95d802580c26bc0dbb24aad'
  })

  depends_on 'coin' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'swig' => :library
end
