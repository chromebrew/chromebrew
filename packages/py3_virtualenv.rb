require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.35.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '',
     armv7l: '',
       i686: '28538c454a137705994b726826f3ae038e7cc6dad6faf58b41519630183f9adf',
     x86_64: '44201ebe7e65bbf7fc07435065a060e2c8a99b16c3f72d894a40e05e1a77f87a'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
