require 'buildsystems/autotools'

class Nettle < Autotools
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.10.2'
  license 'LGPL-3 or LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/nettle/nettle-#{version}.tar.gz"
  source_sha256 'b0fcdd7fc0cdea6e80dcf1dd85ba794af0d5b4a57e26397eee3bc193272d9132'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf3cee5147f3ad81e516b359e2fa9dd53540b2d513b8f02d1d7c3454895832a2',
     armv7l: 'cf3cee5147f3ad81e516b359e2fa9dd53540b2d513b8f02d1d7c3454895832a2',
       i686: 'e7beca22ef8613faac2238abc803b9589cf07a1e02af704f3364093aba176148',
     x86_64: '484cfaf0ff90ece441b0f2122b0e4c7a90209431b2b571678ee45dc6f2edd1d3'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'm4' => :build
  depends_on 'openssl' => :build
end
