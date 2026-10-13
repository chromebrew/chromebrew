require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.65.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a396efb7aff2ee2de2e16c0bbf2599c2b020a3759fd8981c244e0b37ffae86a0',
     armv7l: 'a396efb7aff2ee2de2e16c0bbf2599c2b020a3759fd8981c244e0b37ffae86a0',
       i686: '29a6b79a14995d4d4511247ec4328c479bd1fbef064d3e5cd5079f1ab418ac39',
     x86_64: '10019bcff5941f60ffdbffa250001e3c5120dd71e3a4cb679a549e106d37a345'
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
