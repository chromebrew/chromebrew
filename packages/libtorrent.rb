require 'buildsystems/cmake'

class Libtorrent < CMake
  description 'Feature complete C++ bittorrent implementation focusing on efficiency and scalability.'
  homepage 'https://www.libtorrent.org/'
  version '2.1.0'
  license 'Unknown, BSD-3-Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/arvidn/libtorrent.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e157c53b5d3ed2ab7675764c174ce07d0011dc12b0e3c43f51369686059249b',
     armv7l: '1e157c53b5d3ed2ab7675764c174ce07d0011dc12b0e3c43f51369686059249b',
     x86_64: '9c94b9ed3011819366842359878e61df166e867c3600653c40d27901792825a6'
  })

  depends_on 'boost'
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
end
