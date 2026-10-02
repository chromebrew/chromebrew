require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.64.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf2a0ed7699238246111cd44f24b00a9c0576b0ded48b50a2f7d425c042bc405',
     armv7l: 'bf2a0ed7699238246111cd44f24b00a9c0576b0ded48b50a2f7d425c042bc405',
       i686: 'a1fdcd91ed79c3a7dd5c44f96314634b90bd4a9e29d3c7e365158eefb1184b68',
     x86_64: 'f050ad65b4b6c78720a84bc4f7a45b6b9612ff345cc26f7261a379160fa8ed5e'
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
