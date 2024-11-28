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
       i686: 'd7ab47aaa1a8ba5b8751ce01d9c582686e55a00743f46a9b3cc05f464adbe6ef',
     x86_64: '6353671febc7aca3a41b73bf40c338cadfec81377334e21582249e14115fce3d'
  })

  depends_on 'python3' => :build

  no_source_build
end
