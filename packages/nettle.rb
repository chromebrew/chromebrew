require 'buildsystems/autotools'

class Nettle < Autotools
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.10.1'
  license 'LGPL-3 or LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/nettle/nettle-#{version}.tar.gz"
  source_sha256 'b0fcdd7fc0cdea6e80dcf1dd85ba794af0d5b4a57e26397eee3bc193272d9132'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '059a8950bbfb7e6e5f6eafd42bf6d2b10cad2fe1a591f9d33f05308c0f9a5961',
     armv7l: '059a8950bbfb7e6e5f6eafd42bf6d2b10cad2fe1a591f9d33f05308c0f9a5961',
       i686: '6dbcf360bf7006d199bba24f4a07c9e15cec29a0bff53928a8e5cfc4d0a11daa',
     x86_64: 'd60fe27e37fd0e43f8ad958b197be6967822d2fc91700ff00c970b124e3438ea'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'm4' => :build
  depends_on 'openssl' => :build
end
