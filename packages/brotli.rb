require 'buildsystems/cmake'

class Brotli < CMake
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/google/brotli/archive/v1.1.0.tar.gz'
  source_sha256 'e720a6ca29428b803f4ad165371771f5398faba397edf6778837a18599ea13ff'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.1.0_armv7l/brotli-1.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.1.0_armv7l/brotli-1.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.1.0_i686/brotli-1.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.1.0_x86_64/brotli-1.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd13d057682ef6ded09fd4490d83065e99bd66d23e9f3bc5e34b8b805c289cb95',
     armv7l: 'd13d057682ef6ded09fd4490d83065e99bd66d23e9f3bc5e34b8b805c289cb95',
       i686: '23497dabfe0c426384f5c65fdeb98329f7a2110c1d628d29c95eb5e1d1f5b95d',
     x86_64: '7f5b4bb53f796eff2267b3329588566d259feb136b2b5d2dde7032bde3bfd9bc'
  })

  depends_on 'glibc' # R
end
