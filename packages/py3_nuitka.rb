require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4722b21f00f176cf5332e49d3ab345dec7ad1d50f60269b18c357df11dbffe56',
     armv7l: '4722b21f00f176cf5332e49d3ab345dec7ad1d50f60269b18c357df11dbffe56',
       i686: '456de3e8f290ba05963f04a7692268a1f13e3c07f41f532b6510133678e5ae26',
     x86_64: 'fd3c52ea8fb96eb8913eb093e4f354f2d7dc11e624e6170be494ee78520eaf71'
  })

  depends_on 'python3' => :logical

  no_source_build
end
