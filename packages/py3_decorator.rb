require 'buildsystems/pip'

class Py3_decorator < Pip
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  version "5.3.2-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '341726fe1b80121b412bd7eaa93f00cd4ccbd30a87b2e887671e4d0fa88ac601',
     armv7l: '341726fe1b80121b412bd7eaa93f00cd4ccbd30a87b2e887671e4d0fa88ac601',
       i686: '9f74e628464941b6ae169cddff16964c3a9619791199afb581141dcaaf0fcf8e',
     x86_64: 'd8ac8ab3c73c74dfcae9e3eb3df1797f914afb0fcaabfc19e9e257b5948cd51b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
