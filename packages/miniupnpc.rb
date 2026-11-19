require 'buildsystems/cmake'

class Miniupnpc < CMake
  description 'UPnP IGD client lightweight library'
  homepage 'http://miniupnp.free.fr/'
  version '2.3.5'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/miniupnp/miniupnp.git'
  git_hashtag "miniupnpc_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9437bbcc14e77d7b3e55d281966ed0e829ffbb659ff16c6a80b17c246a5e2715',
     armv7l: '9437bbcc14e77d7b3e55d281966ed0e829ffbb659ff16c6a80b17c246a5e2715',
       i686: '9b0949e58ae5e61c67aac10fe087a51c05d0005d705568c6f132fcb14ed9d375',
     x86_64: 'bb37949783e644f5e9e327bcccaf71deedab5e937e22826618039b05e5b9cc89'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_build_relative_dir 'miniupnpc'
end
