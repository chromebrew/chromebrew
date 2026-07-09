require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.31.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3f89bee55e17c9cffe34a294ceeb6a23fee51213aee4b43a7b3057bbc5c85c0',
     armv7l: 'f3f89bee55e17c9cffe34a294ceeb6a23fee51213aee4b43a7b3057bbc5c85c0',
       i686: 'a7a2cc1d51a4929ea5a7be16f089bb1d16716ac5b7e158dd3c8d2da03039773f',
     x86_64: '543f6781f5c5b9b85e732858ca30c7e38f16dc0282dc1c672cb1db7644474d5f'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :logical

  no_source_build
end
