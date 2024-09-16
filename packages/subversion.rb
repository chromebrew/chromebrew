require 'buildsystems/autotools'

class Subversion < Autotools
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.14.3'
  license 'Apache-2.0, BSD, MIT, BSD-2, FSFAP and unicode'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://dlcdn.apache.org/subversion/subversion-#{version}.tar.bz2"
  source_sha256 '949efd451a09435f7e8573574c71c7b71b194d844890fa49cd61d2262ea1a440'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52d5520e27a6dae64e207ebcabf99bba1f6fe559e8b1c34473b4f9c4c302b32a',
     armv7l: '52d5520e27a6dae64e207ebcabf99bba1f6fe559e8b1c34473b4f9c4c302b32a',
     x86_64: '5569d6fadab22e7032d518f703c42b4fb574bcdd1f33ab1379c37aa374dc69d8'
  })

  depends_on 'apr_util'
  depends_on 'serf'
  depends_on 'sqlite'

  configure_options '--disable-static --with-utf8proc=internal'
end
