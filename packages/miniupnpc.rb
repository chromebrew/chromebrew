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
    aarch64: '6a28719c74e97b2521bb600cd0bb0e96218e90191797ec268ad74669fe52dd05',
     armv7l: '6a28719c74e97b2521bb600cd0bb0e96218e90191797ec268ad74669fe52dd05',
       i686: '92daa3c37ade34a273265adb4f300b306d5d8876cc45c661fa539e8167bc1626',
     x86_64: 'fda08b9ddea8af4da3bdaf162d5279462b2444558b6fbc4be968fc396c671990'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_build_relative_dir 'miniupnpc'
end
