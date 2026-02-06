require 'buildsystems/autotools'

class Nettle < Autotools
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '4.0'
  license 'LGPL-3 or LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/nettle/nettle-#{version}.tar.gz"
  source_sha256 '55f7d9e99b8e2d4e0e193b2f0275501e6d9c1ebd29cadbea6a0da48a8587e3e0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eef51e8b3b3c544f872bbb74c507f72f1629b0bcdd93f41247a4a3d4d95129d0',
     armv7l: 'eef51e8b3b3c544f872bbb74c507f72f1629b0bcdd93f41247a4a3d4d95129d0',
       i686: 'e6a75673d5247664b27b39c25fb0b15aaed2ab4b7b8996aee96b73747c520081',
     x86_64: '6728627c52997ea93fcdf36d277da373a5a6cc620aeefd4e44c5b6887663ce7b'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'm4' => :build
  depends_on 'openssl' => :build
end
