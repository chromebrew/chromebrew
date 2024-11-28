require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.24.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30cc1b0ba285011e317bbe25dcf9f69ee11102a3dcc524c10cbe4bde91e54168',
     armv7l: '30cc1b0ba285011e317bbe25dcf9f69ee11102a3dcc524c10cbe4bde91e54168',
       i686: '1f742968780d3bdd4999ca79d732440aa311fe63c159cc3b0657e20e616ee16b',
     x86_64: '6353671febc7aca3a41b73bf40c338cadfec81377334e21582249e14115fce3d'
  })

  depends_on 'python3' => :build

  no_source_build
end
