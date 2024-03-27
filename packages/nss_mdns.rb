require 'buildsystems/autotools'

class Nss_mdns < Autotools
  description 'NSS module for Multicast DNS name resolution'
  homepage 'https://salsa.debian.org/debian/nss-mdns'
  version '0.15.1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'http://http.debian.net/debian/pool/main/n/nss-mdns/nss-mdns_0.15.1.orig.tar.gz'
  source_sha256 'ddf71453d7a7cdc5921fe53ef387b24fd0c3c49f4dcf94a2a437498596761a21'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60f5c0bf879ab3519ca01b440329641e9213dcc9d4f15f57272378ebdeec7a5e',
     armv7l: '60f5c0bf879ab3519ca01b440329641e9213dcc9d4f15f57272378ebdeec7a5e',
       i686: 'c908298014c7f859cc079b07f5818adf7d34293a530d8a4383bdae587f5332a5',
     x86_64: 'd822b8e05e174d063ae73c925bd8f2f14c5fd4e54a5414524ccee3ed10dd65f5'
  })

  depends_on 'glibc' # R
end
