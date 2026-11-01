require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.3.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '185995f05e7ed225de70bc09eca43a2d930fc293c54fb419d49df1df51a974b6',
     armv7l: '185995f05e7ed225de70bc09eca43a2d930fc293c54fb419d49df1df51a974b6',
       i686: 'ba3ef1636a5ea234105dee356715b9e4d81eaa4cb7ab9b0b889491486d52672b',
     x86_64: '2f30ea3cf92deccd3ecbc08e1c2a4f07b06f4d7e7144d98ab5cfa524eef1dc19'
  })

  depends_on 'python3' => :logical

  no_source_build
end
