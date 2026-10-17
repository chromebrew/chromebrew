require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.66.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c43ab9c227235545c4e4af60d2e6da51eb34bbc11a0530f04cb3e138166a527',
     armv7l: '6c43ab9c227235545c4e4af60d2e6da51eb34bbc11a0530f04cb3e138166a527',
       i686: '272b475540717063abd3658065c2fdfa6c045c09f0d383e53ef2bfcc8cc9e1c8',
     x86_64: 'c98cfbac95f8bc539ee842343ea76d8d3ec96af31a8638fce57c2a4cef373a02'
  })

  depends_on 'py3_filelock'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_six'
  depends_on 'py3_toml'
  depends_on 'py3_virtualenv'
  depends_on 'python3' => :logical

  no_source_build
end
