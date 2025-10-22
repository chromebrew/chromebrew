require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.8.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1e1aba8622c7214aa902c392fa41f1af817307b732c9acf75a8f7c3764b8f4a',
     armv7l: 'e1e1aba8622c7214aa902c392fa41f1af817307b732c9acf75a8f7c3764b8f4a',
       i686: '914f1f1520eb235b085b49549104c5a0760983c1752d5adc9ce9e5fdeba81fed',
     x86_64: 'f1e110b63bc27b6a7123da7c90fd30afd21badc570e265c3fa280b9abe611db8'
  })

  depends_on 'python3' => :build

  no_source_build
end
