require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.15.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eec0a76f21c3dbd0d5eb441744e9aadf63ce93f38973ccfed63c19e873470952',
     armv7l: 'eec0a76f21c3dbd0d5eb441744e9aadf63ce93f38973ccfed63c19e873470952',
       i686: 'dfea314d982e5949074a06a00245cc989fd379ece4d2ae0b75a8d0dd092bd812',
     x86_64: '3620989c85622fa4f6beccd1e3537816c5d2c2c5ec8cc6f927f73714b3e9ed7a'
  })

  depends_on 'python3' => :build

  no_source_build
end
