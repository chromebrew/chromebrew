require 'buildsystems/cmake'

class Libtorrent < CMake
  description 'Feature complete C++ bittorrent implementation focusing on efficiency and scalability.'
  homepage 'https://www.libtorrent.org/'
  version '2.0.12'
  license 'Unknown, BSD-3-Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/arvidn/libtorrent.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '816f7882c4248bcd023a83b51b326429348450a64f94c2fc9ea7803da4575770',
     armv7l: '816f7882c4248bcd023a83b51b326429348450a64f94c2fc9ea7803da4575770',
     x86_64: '043d9b622e92b2b802460f41c80a1bcad57a96c5cfafb18ee4958a9818b4be5c'
  })

  depends_on 'boost'
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'openssl' => :library
end
