require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.35.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c72f6b177f72a26ce035d6b07fa98974740a3f5311426efb9a769d522c7ff1c2',
     armv7l: 'c72f6b177f72a26ce035d6b07fa98974740a3f5311426efb9a769d522c7ff1c2',
       i686: '4c114fb0fe7bdc605c1c469c114ca5574c4660a0cd8f37c58e9baf468e75c8e2',
     x86_64: 'c7bc57766111f7070d2350d4897b5719628b3b4cf08fc6c8aa13cc001966c23b'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
