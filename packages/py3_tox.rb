require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.64.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0eb10b9cec9dd8c162dc9e87a137665e1bed4def1bec9e984be6b684d401d478',
     armv7l: '0eb10b9cec9dd8c162dc9e87a137665e1bed4def1bec9e984be6b684d401d478',
       i686: '08b3267b4192cf24a6d6c09dbe94ea84663542eb9c0d263addc69ef6635f6434',
     x86_64: '37c4d8cfbe67877b485b36bf641362948344b8b9726c59907e589ea875d5e8df'
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
