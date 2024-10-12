require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.25.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '92a5ea7ffbdccb3d397012d72daaed720ac166aabdb6fdba58cd104f545d0caa',
     armv7l: '92a5ea7ffbdccb3d397012d72daaed720ac166aabdb6fdba58cd104f545d0caa',
       i686: 'd826f26c7a3869f3ad61a146574898c51ba50de2e77a31b523c2b4ad94ab22ac',
     x86_64: '4f3165f98cc721bb922c407477ba2ecd3b313be44f2775feb4b0c5d2921f1af0'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :build

  no_source_build
end
