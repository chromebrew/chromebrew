require 'buildsystems/autotools'

class Nettle < Autotools
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.9'
  license 'LGPL-3 or LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/nettle/nettle-#{version}.tar.gz"
  source_sha256 '0ee7adf5a7201610bb7fe0acbb7c9b3be83be44904dd35ebbcd965cd896bfeaa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '059a8950bbfb7e6e5f6eafd42bf6d2b10cad2fe1a591f9d33f05308c0f9a5961',
     armv7l: '059a8950bbfb7e6e5f6eafd42bf6d2b10cad2fe1a591f9d33f05308c0f9a5961',
       i686: '7b0f8d72e3247b515cd413f2eb61e36015be7fe8c8536b6ae476a24a80325c08',
     x86_64: '0f6c3d1add197df8cb44e490f74c7acc8bc696027f9df9d1e51d476af27c7842'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'm4' => :build
  depends_on 'openssl' => :build
end
