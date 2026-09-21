require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.32.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0c9812721be6173a0f14302cb0b6c70f6222830253fbadc1bad9b71a6e3a00e',
     armv7l: 'f0c9812721be6173a0f14302cb0b6c70f6222830253fbadc1bad9b71a6e3a00e',
       i686: '05353a01f176414ea3cd4ea050038f3df4431aa7238bffe2a1344f2994b3380c',
     x86_64: '46913bcccb819c1d92023e9b97848a3d8741dd45a466cde4c169a65bb2f1c392'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :logical

  no_source_build
end
