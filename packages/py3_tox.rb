require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.11-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2211817609834a6cc7670b705626b584b7391de2cf7ca2ac93bfb48d38b0a282',
     armv7l: '2211817609834a6cc7670b705626b584b7391de2cf7ca2ac93bfb48d38b0a282',
       i686: '708d6d84def8371919a3a0e208366c428168e59aa669869b55eb89ee64cb720e',
     x86_64: 'bff2da6e527b33c38c7925826dc5dadadf55213850c3bb0d6dac8caf3dbb1065'
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
