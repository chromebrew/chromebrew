require 'buildsystems/autotools'

class Libxcrypt < Autotools
  description 'Modern library for one-way hashing of passwords'
  homepage 'https://github.com/besser82/libxcrypt/'
  version '4.4.38-1'
  license 'LGPL-2.1+, public-domain, BSD and BSD-2'
  compatibility 'all'
  source_url "https://github.com/besser82/libxcrypt/releases/download/v#{version.split('-').first}/libxcrypt-#{version.split('-').first}.tar.xz"
  source_sha256 '80304b9c306ea799327f01d9a7549bdb28317789182631f1b54f4511b4206dd6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3833e8e660e5b9482cc3ab1ac6151b65d97d784b660da68a9d566d68b8702b0',
     armv7l: 'c3833e8e660e5b9482cc3ab1ac6151b65d97d784b660da68a9d566d68b8702b0',
       i686: '9ce0844a8715e4cd32f4edece1debcc3b830fcf681ba51bf382fb07b128c9565',
     x86_64: '3730fa9845c5a64eeb287c88c7bd5cc0a4af292d07f70ce750b17659f490c12d'
  })

  depends_on 'glibc' # R

  conflicts_ok

  # run_tests
end
