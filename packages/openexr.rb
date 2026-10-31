require 'buildsystems/cmake'

class Openexr < CMake
  description 'OpenEXR is a high dynamic-range (HDR) image file format developed by Industrial Light & Magic for use in computer imaging applications.'
  homepage 'https://openexr.com/en/latest/'
  version '3.5.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/AcademySoftwareFoundation/openexr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff292125b845e9ab9a91211b8371bad1c4db19cebb5c1f5f5bdcb6cd74f6a67f',
     armv7l: 'ff292125b845e9ab9a91211b8371bad1c4db19cebb5c1f5f5bdcb6cd74f6a67f',
       i686: 'c59c36f49415bb3e7d0cbdad469d3a94c6bf20fedf5b50e9620992879a70d9bb',
     x86_64: 'cb7d320d4536d0003e5dcf842a7c783c413dce8c5c4d9b6e69f0a4e72be98e23'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libdeflate' => :library
  depends_on 'zstd' => :library
end
