require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.15-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a870672b0bfc10cb7f937edae154a559434fc5727f48952cadf73600618285d4',
     armv7l: 'a870672b0bfc10cb7f937edae154a559434fc5727f48952cadf73600618285d4',
       i686: '0dc971e72fd38f1941cd596bc193bd204deb377f596acc6abef7963a980df294',
     x86_64: 'fadb47bf652e7724502a109a284cf3a7afeaad081bd48eaef871539eb0297746'
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
