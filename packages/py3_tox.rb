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
    aarch64: '33654e410bb31fe14de31322877f60059f64ac3a11b8f84fa6dc9a64d7d0b5e8',
     armv7l: '33654e410bb31fe14de31322877f60059f64ac3a11b8f84fa6dc9a64d7d0b5e8',
       i686: '026862aa8a46ebc29c4424d992ca0df598112155a72fbdc9b1efb844fa3174ac',
     x86_64: '4fdaae8f6338ef3f798fae531d1991177e588d3638e60b64e68d1ad606c4ce2d'
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
