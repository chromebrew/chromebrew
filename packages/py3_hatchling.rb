require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.28.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '05dbb59fe2cfc9cb0c1ff2bfbac4c308b40ed578a27fe23f8d3e58d4c92c5045',
     armv7l: '05dbb59fe2cfc9cb0c1ff2bfbac4c308b40ed578a27fe23f8d3e58d4c92c5045',
       i686: 'b295a841632e069f86c4048b9a68c97983913ceb0db2306168e4121645e2680b',
     x86_64: 'cad19827c2e451ed551b32f6a22be9a65623901027878792e8fba0c53fe448a7'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :build

  no_source_build
end
