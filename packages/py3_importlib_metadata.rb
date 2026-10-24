require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "10.1.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3cf0650bf987cb449b8698a37299fd5fbf26a58c43b892ffbafdf36f2df382aa',
     armv7l: '3cf0650bf987cb449b8698a37299fd5fbf26a58c43b892ffbafdf36f2df382aa',
       i686: '0158c6e13cef296436c218b93bca485cb941337f098830c4eb670e7b3c60c664',
     x86_64: '001c1bc1914c17db185ae37048a96b410ed0ac8f19fdb94852a870ffeb30246a'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :logical

  no_source_build
end
