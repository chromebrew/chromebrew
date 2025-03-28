require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.25.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5b22baee2b2cafa011239ac42fe88ef001c8783e57cd587ebdcf24dab31516d',
     armv7l: 'f5b22baee2b2cafa011239ac42fe88ef001c8783e57cd587ebdcf24dab31516d',
       i686: '48862092c52ed90cc8abf5588de7aac896195ebbe1af7f3eff23a9ced42b577d',
     x86_64: 'ecc9a6b592035e8f28be688fd7213bbbaf9d0cdc515871158604f294fca7a9e0'
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
