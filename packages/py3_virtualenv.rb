require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.11-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0859fcbd44d1c4390186c51a6d71d7c56b01a0a86eddc6e4456275995545de8',
     armv7l: 'f0859fcbd44d1c4390186c51a6d71d7c56b01a0a86eddc6e4456275995545de8',
       i686: 'a6c817ceb03093c6773ca76aced8c45e341b213cc93e9c6f079256b0e7f71fe9',
     x86_64: '90082ad7006a8f1332721844f291b78fc7926d36a59d5fafca8ac21391a1b07f'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
