require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.35.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb4d3aac96835ffd028c31c49af2789d8262d92a96f2469f0b38924cd9520195',
     armv7l: 'cb4d3aac96835ffd028c31c49af2789d8262d92a96f2469f0b38924cd9520195',
       i686: '8cb4765e5777c6d929b3499b0e340005c6075ce84b02d42d5a63625f876b29d6',
     x86_64: '73f8cbbf2af61999ecb6fb0c2e59af775338eee15a6ecfe1db5e86c02dcee2b6'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
