require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c3958029cbf8ee5819f3afd94e0605fb87a88ce42c339d356acaa7cb652f4a5',
     armv7l: '0c3958029cbf8ee5819f3afd94e0605fb87a88ce42c339d356acaa7cb652f4a5',
       i686: '9db60c41819c13a63099727e3e68f98efc9dc516393f3a6f0dd8bd38b628b2f8',
     x86_64: '344d8737a6c2eeecb95e395ea8291ac0bfd5d59bde259748290c3b6aea5851ea'
  })

  depends_on 'python3' => :logical

  no_source_build
end
