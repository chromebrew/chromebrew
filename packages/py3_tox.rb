require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.34.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f572ef9582d9f3a7ca3a858e38632905239f8d6c2dd89a559e38671728649c6',
     armv7l: '7f572ef9582d9f3a7ca3a858e38632905239f8d6c2dd89a559e38671728649c6',
       i686: 'ea1bb6b40f4c31e4491405b734e7504313716f5a87401a7b1665fe1c92ac9953',
     x86_64: 'ba55193fe416dc3df94d000c1a9a337674981dba9be86a012130cbbe2f860966'
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
