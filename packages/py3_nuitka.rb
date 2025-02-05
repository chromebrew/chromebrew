require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd12ae7c573366cdf3ce0e9e358dac734ee9e141d2454414997373ac7d0453b2d',
     armv7l: 'd12ae7c573366cdf3ce0e9e358dac734ee9e141d2454414997373ac7d0453b2d',
       i686: 'b6bcaa2975edae3d51c781cd98eea150724b60aa133dfe6709038ded17bd60f7',
     x86_64: '6ffd17fe326bfd08d1b0e235faec866782ab7bcd99ae97a0a647ca848c207f03'
  })

  depends_on 'python3' => :build

  no_source_build
end
