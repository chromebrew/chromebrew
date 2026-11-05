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
    aarch64: 'c28efb75594c37755b3f9d163b2559819038e6aae4062a2a3c4f1105dd381ef1',
     armv7l: 'c28efb75594c37755b3f9d163b2559819038e6aae4062a2a3c4f1105dd381ef1',
       i686: '7e2180a47809928e920610da17c20952753bbdbde2a992ea774ef7b869dc9ec2',
     x86_64: '3ec5bd1ab5ee106b6ad03df008db006c84b35e3004772331704f805d02b02791'
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
