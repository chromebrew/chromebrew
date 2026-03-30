require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "7.4.0.post2-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb816d5ce23f83e6fde0e29fb0ab17395169932986b8a1ad3dc1751eb89fa530',
     armv7l: 'cb816d5ce23f83e6fde0e29fb0ab17395169932986b8a1ad3dc1751eb89fa530',
       i686: 'd034b1fd6078682d8e3c583b27791eb64582c62f45e20a140f7674893744c0ad',
     x86_64: 'aa15e77266eaa68eb87147453aefbe44fd3e899d8cf38d410824a3259b5dd6b4'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
