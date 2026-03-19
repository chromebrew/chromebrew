require 'buildsystems/autotools'

class Libxvid < Autotools
  description 'The free video codec that is strong in compression and quality.'
  homepage 'https://www.xvid.com/'
  version '1.3.7'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.xvid.com/downloads/xvidcore-#{version}.tar.bz2"
  source_sha256 'aeeaae952d4db395249839a3bd03841d6844843f5a4f84c271ff88f7aa1acff7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0587f20f1a2ea2ede14054ccddfc2fbef2a0ef5b611c3ba679c0d1724da365eb',
     armv7l: '0587f20f1a2ea2ede14054ccddfc2fbef2a0ef5b611c3ba679c0d1724da365eb',
       i686: '2d398811d6468a57dd236907d7b2e8a71263fba2423d3baf4d04f8f1b7ac5b1a',
     x86_64: 'e990606cef5b83dcffa96e6595538240934c6f926ca49701c165322811f8a44f'
  })

  depends_on 'yasm' => :build

  autotools_pre_configure_options 'CFLAGS=-std=c99'
  autotools_build_relative_dir 'build/generic'
end
