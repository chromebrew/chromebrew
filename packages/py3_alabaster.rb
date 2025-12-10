require 'buildsystems/pip'

class Py3_alabaster < Pip
  description 'Alabaster is a configurable sidebar-enabled Sphinx theme.'
  homepage 'https://alabaster.readthedocs.io/'
  version "1.0.0-#{CREW_PY_VER}"
  license 'BSD' # License is BSD-style, might be BSD-3?
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79059b7acd1296d3ebb91ba850206e7b08786508a2a048de84da82f6fb396b37',
     armv7l: '79059b7acd1296d3ebb91ba850206e7b08786508a2a048de84da82f6fb396b37',
       i686: '471c06a52ee38ee79cc99a1efc1172b680ed233fb58a5f886a485a59c92a450e',
     x86_64: '133a5f452953bdabe49fde5e0e9b98b7fa4b4bd00e6a7d5ed00bd07068f0f199'
  })

  depends_on 'python3' => :build

  no_source_build
end
