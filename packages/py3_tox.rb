require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e06978d066010eb1f9b656e83e05485bdfae6469917613bc02b5487b5949e2c2',
     armv7l: 'e06978d066010eb1f9b656e83e05485bdfae6469917613bc02b5487b5949e2c2',
       i686: '4e43f5412ef85a6580dc53bcf9ccf440a5ce053e0ed23e0706b060b415cdf80c',
     x86_64: 'ce76b97e4edbd0384605d0c0922e3016e25be331a1543fb7b97411b54477ebed'
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
