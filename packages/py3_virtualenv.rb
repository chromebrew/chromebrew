require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '949c67a4cdd4286ddf99d2818bc22860a6625cbf8e47c2d2ed86019d284a013d',
     armv7l: '949c67a4cdd4286ddf99d2818bc22860a6625cbf8e47c2d2ed86019d284a013d',
       i686: 'b7832d53d2d23488c2cb13d9adafe2dbf25c58484fe18aaa381cda2e0753d28b',
     x86_64: 'c77f4a893c8819808a4ac6418e075dbe74b7c3cd612f198205f60c3dd51f42a3'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
