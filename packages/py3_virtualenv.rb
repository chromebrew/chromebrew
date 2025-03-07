require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.29.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7ebc77a28e53becb6dc17309acd31a854640fb401abd382e55c76128f94276f',
     armv7l: 'd7ebc77a28e53becb6dc17309acd31a854640fb401abd382e55c76128f94276f',
       i686: '60980a32f4a3d8c67d8a27f8456eb27b7c10f31158b59e72af6738703da1ebcb',
     x86_64: '6283573d18d100aa5b321d576660a1fd022b63096c056eafa3ae8b5d7fa8c839'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
