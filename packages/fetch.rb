require 'buildsystems/cmake'

class Fetch < CMake
  description 'FreeBSD Fetch retrieves files by URL.'
  homepage 'https://github.com/jrmarino/fetch-freebsd'
  version '14.0.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/jrmarino/fetch-freebsd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dacc2b3444809a5d13a7f32b71da70a7ae1b27a8a2c73d104247b54bcb2b59ed',
     armv7l: 'dacc2b3444809a5d13a7f32b71da70a7ae1b27a8a2c73d104247b54bcb2b59ed',
       i686: '2e829b7ca0cae06ee76b9cc7f5a3966d03d4c9b9903a2d8a882f6775e0f6774d',
     x86_64: '86f5c343873726a238af393e09519acf94b0339787701531ac1ad75f751af9dc'
  })

  depends_on 'glibc' # R
  depends_on 'openssl'

  cmake_options '-DFETCH_LIBRARY=ON -DUSE_SYSTEM_SSL=ON'
end
