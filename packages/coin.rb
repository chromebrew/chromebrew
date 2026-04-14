require 'buildsystems/cmake'

class Coin < CMake
  description 'OpenGL-based, 3D graphics library'
  homepage 'https://github.com/coin3d/coin'
  version '4.0.8'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/coin3d/coin.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '07069eeab10177af002b2165c3e027d21e9d3b7e5d7d54b76a7e5e8b779d6c08',
     armv7l: '07069eeab10177af002b2165c3e027d21e9d3b7e5d7d54b76a7e5e8b779d6c08',
     x86_64: '73a69833e54066a8cc21bae31267fcc33b6a10bf8e17e7073048ef9a6be8a761'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libx11' => :library

  run_tests
end
