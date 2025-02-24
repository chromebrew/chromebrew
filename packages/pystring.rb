require 'buildsystems/cmake'

class Pystring < CMake
  description 'C++ functions matching the interface and behavior of python string methods with std::string'
  homepage 'https://github.com/imageworks/pystring'
  version '1.1.4'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/imageworks/pystring.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b3fd97e42e4eb60cb7d990a5c7dc6617ac6beed17d16c11e61b0bf21f17c6c0',
     armv7l: '1b3fd97e42e4eb60cb7d990a5c7dc6617ac6beed17d16c11e61b0bf21f17c6c0',
       i686: '2a675d043ff2c582afb192bb866f84ecbfa1627c4206f4f75dd597936270a2ad',
     x86_64: '6d197cf0aed008c2ec7207ef6d23ed0371d2da443b39096e68da95fccba79f68'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
