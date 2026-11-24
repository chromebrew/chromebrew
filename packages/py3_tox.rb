require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.16-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0209507a90787784633d3b6fd900425ac76bdf2d758b57e5f93df79f15a04ce3',
     armv7l: '0209507a90787784633d3b6fd900425ac76bdf2d758b57e5f93df79f15a04ce3',
       i686: '88b516e353bd3b9307a251e4db444b03d11f668d537c0207a48a57b4aa485a3b',
     x86_64: '8e0f5583351b78d6b225056ebb7fedf58ab2ee330906c03a05426144a2b49de3'
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
