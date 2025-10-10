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
    aarch64: '507b17fe7387457863cac629e26f8eee3f6121ef4728ba011d8d9988cdaac329',
     armv7l: '507b17fe7387457863cac629e26f8eee3f6121ef4728ba011d8d9988cdaac329',
       i686: '6ba937b99f807c3fa497b91f862334d6c43cce021579e87fecdc017730c2d3ea',
     x86_64: '8537a2a1e084f8472c81195d928aa53ca3402e549fafee371626515d79b4b9a4'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
