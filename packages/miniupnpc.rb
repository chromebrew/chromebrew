require 'buildsystems/cmake'

class Miniupnpc < CMake
  description 'UPnP IGD client lightweight library'
  homepage 'http://miniupnp.free.fr/'
  version '2.3.3'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/miniupnp/miniupnp.git'
  git_hashtag "miniupnpc_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf163ac0912951443577a91ed6c89e3f269e129b1b7860a2145e6620bdac07e0',
     armv7l: 'bf163ac0912951443577a91ed6c89e3f269e129b1b7860a2145e6620bdac07e0',
       i686: 'af826ef511ea524d0a8245f4d668254c50588676f261411033607388c6814ce6',
     x86_64: '491990bc8083e746f871521fd42b91f66f0673f0b7d66bb3610dec6848050c0f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_build_relative_dir 'miniupnpc'
end
