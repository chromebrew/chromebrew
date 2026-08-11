require 'buildsystems/cmake'

class Libtorrent < CMake
  description 'Feature complete C++ bittorrent implementation focusing on efficiency and scalability.'
  homepage 'https://www.libtorrent.org/'
  version '2.1.1'
  license 'Unknown, BSD-3-Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/arvidn/libtorrent.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84f9dd0bb373c3bd85daa52da1aa2522192edcb9bf187e72387ffc87d32ddd08',
     armv7l: '84f9dd0bb373c3bd85daa52da1aa2522192edcb9bf187e72387ffc87d32ddd08',
     x86_64: '3cf6cc1cc0b9888251a423440f9b424c2d974acc185c0e9e886d8ea831fb382d'
  })

  depends_on 'boost'
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
end
