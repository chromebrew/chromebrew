require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.11-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bca0186779e6e29147c70ac438c11181e8a17ae2ebbdd34fdfc9adca6991eee8',
     armv7l: 'bca0186779e6e29147c70ac438c11181e8a17ae2ebbdd34fdfc9adca6991eee8',
       i686: '80b6fb63833e8d3094bbf852af02c37f3a1a2ec22a69873f42df4c77df19c9b1',
     x86_64: 'ea44acc0ebb36cb7fac8d427843990b1e7f8e5fec8d6a7c3b4571c26d2fa5f02'
  })

  depends_on 'python3' => :build

  no_source_build
end
