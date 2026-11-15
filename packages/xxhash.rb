require 'buildsystems/cmake'

class Xxhash < CMake
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'https://xxhash.com/'
  version '0.8.4'
  license 'BSD-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/Cyan4973/xxHash.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6b8618e815d00d30ecf5608a9a5534719a960b336a9a76bbe77737733777ac3',
     armv7l: 'd6b8618e815d00d30ecf5608a9a5534719a960b336a9a76bbe77737733777ac3',
       i686: '1696bc471fdaa6db98c8924e55484019e67a438b21636e7a40d068386ba79292',
     x86_64: '4b3d2e704b32dd92a856df95a2dbca75b6e2a60ed1824cb58d97c940844412a9'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_build_relative_dir 'build/cmake'
end
