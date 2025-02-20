require 'buildsystems/cmake'

class Xxhash < CMake
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'https://xxhash.com/'
  version '0.8.3'
  license 'BSD-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/Cyan4973/xxHash.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ad8cdd3611bf8336070ec55d92c30cae584656c3720ca2368101826ca089c4a',
     armv7l: '7ad8cdd3611bf8336070ec55d92c30cae584656c3720ca2368101826ca089c4a',
       i686: 'aa0cf401c897bbc840c9ff70e2db304370ce5701a2d9a72c5555923531c696ad',
     x86_64: '496635d53101cadaa23d7ca7467525a2762c755cbdef99bc9721fb17dd2ba856'
  })

  depends_on 'glibc' # R

  cmake_build_relative_dir 'cmake_unofficial'
end
