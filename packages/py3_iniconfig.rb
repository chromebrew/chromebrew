require 'buildsystems/pip'

class Py3_iniconfig < Pip
  description 'Iniconfig provides simple config-ini parsing.'
  homepage 'https://github.com/pytest-dev/iniconfig/'
  version "2.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ebc496e199acf917775241ca50190e8a46e86b07175404fdac5e353a82b80e0',
     armv7l: '4ebc496e199acf917775241ca50190e8a46e86b07175404fdac5e353a82b80e0',
       i686: '10cca85f9f59fce4c8e3657f767f31c73088ce9a5a2d0c44c7885d5207ee0053',
     x86_64: '4c2fbdb432cb29b095b226abf358069676524625233344a6e9e1e1e89ec6eb5f'
  })

  depends_on 'python3' => :build

  no_source_build
end
