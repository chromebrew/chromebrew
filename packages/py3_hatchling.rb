require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.26.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '090259a56a1746bfb2ccf91acdeddfe6f1d03954c81884b8b71d3a7e47cdbdfb',
     armv7l: '090259a56a1746bfb2ccf91acdeddfe6f1d03954c81884b8b71d3a7e47cdbdfb',
       i686: '71eb71c2c108c903d4ce7c1d8ba0a19422357c4054e5b9748a075c8aa20b5953',
     x86_64: '9f3a0241924634fe9ecdf03ebc2f5e9271370f607f7891be99454c2146d49ccf'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :build

  no_source_build
end
