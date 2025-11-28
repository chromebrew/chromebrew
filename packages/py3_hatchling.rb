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
       i686: 'db1dba0c7d3bd4345609c8925643d95eec693db3f09a6d0465d2d5828aeeaff5',
     x86_64: '10e60e8a5fe0e200d9f33dd8463a4dc80a3b425700454dfd64d315190f8963fc'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :build

  no_source_build
end
