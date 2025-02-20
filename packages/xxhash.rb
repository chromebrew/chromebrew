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
       i686: '5d70bb5ac38e15afd006ac0c6957ef81cfae0a05d27428ffbc3501b7b899cd10',
     x86_64: 'c1f0005397d8433a33ab6195f82d7f17e6271530599ad52538c6550360b97afc'
  })

  depends_on 'glibc' # R

  cmake_build_relative_dir 'cmake_unofficial'
end
