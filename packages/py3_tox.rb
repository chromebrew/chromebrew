require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.64.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0e86b98d9604c425dfc1e26384568f20a3354a64edf94d1a9d075d29b2e3d5f',
     armv7l: 'e0e86b98d9604c425dfc1e26384568f20a3354a64edf94d1a9d075d29b2e3d5f',
       i686: 'a6ecc81d0fa7fc79d700fb88ea5fb397a2c51b767286f7aeb1035c37a3f96ed9',
     x86_64: '177203de90bed9aa895efd879f418fa171569cdd18eeace48db0e175f3c18b8c'
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
