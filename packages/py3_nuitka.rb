require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.4.11-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
     armv7l: 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
       i686: '8a4d03d506d31951c78e2d22d088883544fe346f8113b43e23a45cb1f68e77e9',
     x86_64: 'ba825500a278ce77094b867d25ce75109dbbdd4dbb457736eaa56e2b6dd6e44d'
  })

  depends_on 'python3' => :build

  no_source_build
end
