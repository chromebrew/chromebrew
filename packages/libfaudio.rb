require 'buildsystems/cmake'

class Libfaudio < CMake
  description 'FAudio is an XAudio reimplementation that focuses solely on developing fully accurate DirectX Audio runtime libraries for the FNA project.'
  homepage 'https://fna-xna.github.io/'
  version '25.09'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fna-xna/faudio.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16d537cd1423264d547bee428074d9436cd6b97151084278d7f0673d76403220',
     armv7l: '16d537cd1423264d547bee428074d9436cd6b97151084278d7f0673d76403220',
     x86_64: '1ac90749a48cbdc63f299374a3a962598b53a4045b38da95c47627e7c05ebd02'
  })

  depends_on 'glibc' # R
  depends_on 'sdl3' # R
end
