require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.13.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdda119677743af10138aef9831a1be963798f58ba6b563080078183288ad28a',
     armv7l: 'bdda119677743af10138aef9831a1be963798f58ba6b563080078183288ad28a',
       i686: '3507dcc272ee555e06ced72f426f6f10cd3a03b99b4b08dce36b9b744fe43aa2',
     x86_64: 'eece44075614d5ec0188638080d594e1bb0bee828bf610da55374628731928c7'
  })

  depends_on 'python3' => :build

  no_source_build
end
