require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.23.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd30883d52a4aedcb4d6915df60cc50b864f7301b642dc28b6a93c9d6b8c7257',
     armv7l: 'cd30883d52a4aedcb4d6915df60cc50b864f7301b642dc28b6a93c9d6b8c7257',
       i686: 'd7ab47aaa1a8ba5b8751ce01d9c582686e55a00743f46a9b3cc05f464adbe6ef',
     x86_64: '5c6e54c943c38bb39b48a34ffaba1129230d192e23faea783878767e0d71f1bd'
  })

  depends_on 'python3' => :build

  no_source_build
end
