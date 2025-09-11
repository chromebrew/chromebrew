require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.9.11.17-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3136c5fb91739d6b142a99a23b4715d18af1786f4f1c369b93a7940953e50f0c',
     armv7l: '3136c5fb91739d6b142a99a23b4715d18af1786f4f1c369b93a7940953e50f0c',
       i686: '7a4bf94204cd2e20a022b95cde55244753430a7e64c5683ca4dba7f5ed63aed6',
     x86_64: '03d10a22870dd869da4f88b702ce2f8a6daf9c4f184a029f928ece3f2c224b16'
  })

  depends_on 'python3' => :build

  no_source_build
end
