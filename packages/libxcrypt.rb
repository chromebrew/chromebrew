require 'buildsystems/autotools'

class Libxcrypt < Autotools
  description 'Modern library for one-way hashing of passwords'
  homepage 'https://github.com/besser82/libxcrypt/'
  version '4.5.1'
  license 'LGPL-2.1+, public-domain, BSD and BSD-2'
  compatibility 'all'
  source_url "https://github.com/besser82/libxcrypt/releases/download/v#{version.split('-').first}/libxcrypt-#{version.split('-').first}.tar.xz"
  source_sha256 'e9b46a62397c15372935f6a75dc3929c62161f2620be7b7f57f03d69102c1a86'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '019df8725b2ebc7aea3529790d1c2b2131f64d93f7f689037e55a0622723235e',
     armv7l: '019df8725b2ebc7aea3529790d1c2b2131f64d93f7f689037e55a0622723235e',
       i686: '739e6f16be59e5e074a3f4c4928e61e94bccb31476037c4529776e53a9985e06',
     x86_64: '14156219928801fcd4f9500c55ef7e03781e1cfefa5d5090bd5847c881aa352d'
  })

  depends_on 'glibc' # R

  conflicts_ok
  no_lto

  # Handle https://github.com/besser82/libxcrypt/issues/181
  ENV['CREW_LINKER_FLAGS'] = '-Wl,--undefined-version'
  # run_tests
end
