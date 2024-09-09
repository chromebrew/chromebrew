require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version '3.20.0-py3.12'
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e42d4bca9c3f3fc6e4603c56c63460eeffbea74bffc37ae7621b61f819eba35',
     armv7l: '7e42d4bca9c3f3fc6e4603c56c63460eeffbea74bffc37ae7621b61f819eba35',
       i686: '08f714bd2e1c45a93bf47ba4aacadf267ef3121b8f4ddf27ea0017944c7391b1',
     x86_64: '467ceddc55434ad4e530a5fe1348abdb7c2bb6174dfa9230c6c15a49eb874907'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  no_source_build
end
