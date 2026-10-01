require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.2.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b268481b774a39f48cb57f70223258ffb959bfd9a87d1f84e4dadb865d36388a',
     armv7l: 'b268481b774a39f48cb57f70223258ffb959bfd9a87d1f84e4dadb865d36388a',
       i686: '894ddc40edb586ef79fae4c64f4b344c9ccc999db1654aff51431cd794610d6f',
     x86_64: '72c2f26d3c712ebd21429bac506962979d08a17bec84595dca39776843f7a20b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
