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
    aarch64: 'e10f8410b71dc1c46a800de1af6d491ba780c53f870fd4eb2b12a6e7b5e39835',
     armv7l: 'e10f8410b71dc1c46a800de1af6d491ba780c53f870fd4eb2b12a6e7b5e39835',
     x86_64: '627ff09c68e4d82df66815b7cb0c59c05e06cb0c8b5a8206d68d9855546d8203'
  })

  depends_on 'boost'
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
end
