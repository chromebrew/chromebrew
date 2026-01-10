require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.34.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e61722bbb8b65a6d40380f091f3a0cf672045e5e12745cb1685d76a57ca27e3',
     armv7l: '7e61722bbb8b65a6d40380f091f3a0cf672045e5e12745cb1685d76a57ca27e3',
       i686: '50eae197c1661f0a600fa9707e4ca30a11de3c754fe37956cd2d516a17ed5fd9',
     x86_64: '044df7aa896d260bfeb078d821b68472f77b19041f23303cab13067540e9444e'
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
