require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.30.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '313d377cbad95984773804dd06bd7e59b80dbce56f466f7506623603c4238963',
     armv7l: '313d377cbad95984773804dd06bd7e59b80dbce56f466f7506623603c4238963',
       i686: 'd9a690ea0c2c73d5512d82a1d0c83c34564e45eae2ccff392a213d00e1655172',
     x86_64: 'd8e398d54f6dbbeaa63318090edd4044fcfdd3cf45c61197b338767c000af1db'
  })

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'python3' => :build

  no_source_build
end
