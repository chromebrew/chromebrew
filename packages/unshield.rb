require 'buildsystems/cmake'

class Unshield < CMake
  description 'Tool and library to extract CAB files from InstallShield installers.'
  homepage 'https://github.com/twogood/unshield'
  version '1.6.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/twogood/unshield.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e6005b7fe0eeb5a64c336af648e16d04207f9cdb6476a68f6a9c165dd3ab5ee',
     armv7l: '2e6005b7fe0eeb5a64c336af648e16d04207f9cdb6476a68f6a9c165dd3ab5ee',
       i686: 'fe3f598bedf0d4dc59c8febda66fa6ee542f9f6f3a8163a7f9a87ac27ccdef45',
     x86_64: 'e7951ed96464f38e34982f08d212f29466e6f0040f3ee4afb411e67b9b5733c3'
  })

  depends_on 'glibc' => :library
  depends_on 'openssl' => :library
  depends_on 'zlib' => :library
end
