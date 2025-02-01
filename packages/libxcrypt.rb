require 'buildsystems/autotools'

class Libxcrypt < Autotools
  description 'Modern library for one-way hashing of passwords'
  homepage 'https://github.com/besser82/libxcrypt/'
  version '4.4.38'
  license 'LGPL-2.1+, public-domain, BSD and BSD-2'
  compatibility 'all'
  source_url "https://github.com/besser82/libxcrypt/releases/download/v#{version}/libxcrypt-#{version}.tar.xz"
  source_sha256 '80304b9c306ea799327f01d9a7549bdb28317789182631f1b54f4511b4206dd6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da8f6564a1aed32e2d31c2a349cecd2754c6914325379a3f797c86b02765ac1f',
     armv7l: 'da8f6564a1aed32e2d31c2a349cecd2754c6914325379a3f797c86b02765ac1f',
       i686: '1335e04f868ecb914a00c9fed2746009d19f65b1a2961f47aebf2cc5634e346e',
     x86_64: '5c6d9f5fdb8af6d2b86652e9cb51156fcc6a7f44d7db4f6f46ee826f3deb58b7'
  })

  depends_on 'glibc' # R

  conflicts_ok

  # run_tests
end
