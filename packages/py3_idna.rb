require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.12-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9522c57f126213c51538777a67b964d1c2b5fa0b1b31470152c97a0b797aa21b',
     armv7l: '9522c57f126213c51538777a67b964d1c2b5fa0b1b31470152c97a0b797aa21b',
       i686: '6a8533003524ec8a6a3376ce967deb9e2be7e410a5e3acd7057360b6cb147ece',
     x86_64: '24a42047fda4e2f39097bb7b396c7751e6fa9f645cef32bae2f42fb44ba2e60d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
