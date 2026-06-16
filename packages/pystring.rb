require 'buildsystems/cmake'

class Pystring < CMake
  description 'C++ functions matching the interface and behavior of python string methods with std::string'
  homepage 'https://github.com/imageworks/pystring'
  version '1.2.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/imageworks/pystring.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b44f6d5b573aba31f46d5c9b5813d65685653be10f38a5bb02b6bf5f4c2c61d0',
     armv7l: 'b44f6d5b573aba31f46d5c9b5813d65685653be10f38a5bb02b6bf5f4c2c61d0',
       i686: '07f64670473ca40b408ad24ecd42f8dc3e5d4d9b90d9c416c090c98fa1eb067b',
     x86_64: '1d836f7d46fefe1d35ac17fbfd5d2230344d002c128da7270605d7a231a641a1'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
