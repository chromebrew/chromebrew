require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2024.10.16-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6248d6b73c291f8b749068b67746b610ed1233471821f237adef438c9851b701',
     armv7l: '6248d6b73c291f8b749068b67746b610ed1233471821f237adef438c9851b701',
       i686: 'd161750ad519a85128593820a0e72b8974610dbc81b4ed4f1b15983fbbdfbcde',
     x86_64: '14d88f60dc8cf2583242c21ae9e416cbe28749c38ea576db6535167a27feaa2f'
  })

  depends_on 'python3' => :build

  no_source_build
end
