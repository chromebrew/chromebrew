require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.3.19.19-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ddb4ab1824830e51d57d7e086579ec85d6fe3ce0412c2ae8bef401f6f70d4822',
     armv7l: 'ddb4ab1824830e51d57d7e086579ec85d6fe3ce0412c2ae8bef401f6f70d4822',
       i686: '697befeb909ac80e8af7face99ed5a203428f6a393547e3926bb3242c72f5c3e',
     x86_64: '7d07a6c780447bc85a20106d4be50ab09eb24c2b7c48ae29a48ebb712098aa34'
  })

  depends_on 'python3' => :build

  no_source_build
end
