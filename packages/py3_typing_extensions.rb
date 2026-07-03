require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.16.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c6d6c514d0844380b6a3f10f8571bd04af7119a6218baa5acf20a2a50b49b13',
     armv7l: '2c6d6c514d0844380b6a3f10f8571bd04af7119a6218baa5acf20a2a50b49b13',
       i686: '7f5b0294246c36c3d91ae92b57bfcd2ff5faba03ff5b034b9d642960b9050390',
     x86_64: '4e1002fb76e49d24185417a888a9813ab5e6a9ca9400a1784bcd6458bc28ab29'
  })

  depends_on 'python3' => :logical

  no_source_build
end
