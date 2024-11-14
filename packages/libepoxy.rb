require 'buildsystems/meson'

class Libepoxy < Meson
  description 'Epoxy is a library for handling OpenGL function pointer management for you'
  homepage 'https://github.com/anholt/libepoxy'
  version '1.5.10'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/anholt/libepoxy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '66b8a7eaa527e20d68e6e1834b4007b1f4b486bd6ad13bb31e46dc7287a75758',
     armv7l: '66b8a7eaa527e20d68e6e1834b4007b1f4b486bd6ad13bb31e46dc7287a75758',
     x86_64: '42b3fb3462233d166eac6af5755972df60042e06a3230a72357fe8c121ae8591'
  })

  depends_on 'mesa' => :build
  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_lto
end
