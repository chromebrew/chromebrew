require 'buildsystems/cmake'

class Libtorrent < CMake
  description 'Feature complete C++ bittorrent implementation focusing on efficiency and scalability.'
  homepage 'https://www.libtorrent.org/'
  version '2.1.2'
  license 'Unknown, BSD-3-Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/arvidn/libtorrent.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d5fe0a78cec9f8c99d2761e82a28054926537d9e1e04f788bcc78a3e4ef32cb',
     armv7l: '8d5fe0a78cec9f8c99d2761e82a28054926537d9e1e04f788bcc78a3e4ef32cb',
     x86_64: 'e38a9abf5015869535d2113669d34e649d9b60ef7fe0669f6f714b3063b49e85'
  })

  depends_on 'boost'
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
end
