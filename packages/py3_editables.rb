require 'buildsystems/pip'

class Py3_editables < Pip
  description 'A Python library for creating "editable wheels"'
  homepage 'https://editables.readthedocs.io'
  version "0.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae8fc003159785d26744d581c3842c66f9cf2bbebc9d7b94eba059d97f6c169d',
     armv7l: 'ae8fc003159785d26744d581c3842c66f9cf2bbebc9d7b94eba059d97f6c169d',
       i686: '7285e47b7daa821ce211b67abeb55bb4770e416e6b501c307788eeed02073b3a',
     x86_64: '72995425085ce1cfa8df30088bd30c0282b871ea7d7149028d6e4ecbe40fd83a'
  })

  depends_on 'python3' => :build

  no_source_build
end
