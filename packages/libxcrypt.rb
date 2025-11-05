require 'buildsystems/autotools'

class Libxcrypt < Autotools
  description 'Modern library for one-way hashing of passwords'
  homepage 'https://github.com/besser82/libxcrypt/'
  version '4.5.0'
  license 'LGPL-2.1+, public-domain, BSD and BSD-2'
  compatibility 'all'
  source_url "https://github.com/besser82/libxcrypt/releases/download/v#{version.split('-').first}/libxcrypt-#{version.split('-').first}.tar.xz"
  source_sha256 '825e764e4ff2e6304adb814cda297074b222d54a04edbd8ebc7cf58fc3af857d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d05e41212deaaf128aefbea85878ff9fdc20546d73a1fa90b2bf4d889f4ec06',
     armv7l: '9d05e41212deaaf128aefbea85878ff9fdc20546d73a1fa90b2bf4d889f4ec06',
       i686: 'd56a4db8e46c68e2d99035cb7f70339f894c206e736994dbf4100a29aec6fb21',
     x86_64: '302ac5779bd28f5d54eac4b3e944faf27c5e7d4ad3f9b82304fa571950a53919'
  })

  depends_on 'glibc' # R

  conflicts_ok
  no_lto

  # Handle https://github.com/besser82/libxcrypt/issues/181
  ENV['CREW_LINKER_FLAGS'] = '-Wl,--undefined-version'
  # run_tests
end
