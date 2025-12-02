require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.12.1.14-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f821f3ec10686595cae012670b50eef2758112bbc80e7ffa76254f30cb065dcb',
     armv7l: 'f821f3ec10686595cae012670b50eef2758112bbc80e7ffa76254f30cb065dcb',
       i686: '082bf9aa45ffdd344eb42f3f33bfdcb5b4bccbfbd20e05f86f304f3aff4ad489',
     x86_64: '1282bbacbdf25bc4d2969ba9569e4a6a975a3be92010aeb40099afe7b09d34d0'
  })

  depends_on 'python3' => :build

  no_source_build
end
