require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.56.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1608381c783f71f400db487036c9b4a676c3005b8adb7bb92abe520cba8cc74c',
     armv7l: '1608381c783f71f400db487036c9b4a676c3005b8adb7bb92abe520cba8cc74c',
       i686: '1eb14cf59ae28431c7657aac8d35322c8a6b8198fd9021fe98d601335bcacbeb',
     x86_64: 'd8b428133598137439c5ff824a877e7ff108634a6330c8f4c3ddf4835fedd69a'
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
