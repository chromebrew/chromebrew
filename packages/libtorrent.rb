require 'buildsystems/cmake'

class Libtorrent < CMake
  description 'Feature complete C++ bittorrent implementation focusing on efficiency and scalability.'
  homepage 'https://www.libtorrent.org/'
  version '2.1.3'
  license 'Unknown, BSD-3-Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/arvidn/libtorrent.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab396019770d1bfa85a97560f35084ea56fc1590332bbe236db2b972c3942391',
     armv7l: 'ab396019770d1bfa85a97560f35084ea56fc1590332bbe236db2b972c3942391',
     x86_64: '649b01c9095451dc3deca433caf526c0e5fe42bacd59287edf388d06f2816cb3'
  })

  depends_on 'boost'
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
end
