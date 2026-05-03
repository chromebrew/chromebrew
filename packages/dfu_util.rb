require 'buildsystems/autotools'

class Dfu_util < Autotools
  description 'DFU is intended to download and upload firmware to/from devices connected over USB.'
  homepage 'http://dfu-util.gnumonks.org/'
  version '0.11'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://dfu-util.sourceforge.net/releases/dfu-util-#{version}.tar.gz"
  source_sha256 'b4b53ba21a82ef7e3d4c47df2952adf5fa494f499b6b0b57c58c5d04ae8ff19e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '393f127d2761c1e4eeb7e62f06f563197d4030fea12d67179a7993ee8d9ccb19',
     armv7l: '393f127d2761c1e4eeb7e62f06f563197d4030fea12d67179a7993ee8d9ccb19',
       i686: '1735c55bf504f8741177c9ce7e28fc4078abbf07721de8cc6e32d5b40679a28c',
     x86_64: '81c4ac4962732bdc6dd214e44f2f16e32dd5e4e79602bf46dab18a6e911e48de'
  })

  depends_on 'glibc' => :executable
  depends_on 'libusb' => :executable

  run_tests
end
