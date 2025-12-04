require 'buildsystems/pip'

class Py3_brotlicffi < Pip
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  version "1.2.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8e7cee7d0ffe586cff24211d1af56ab47f2a6a2c76b1474a5b5370fccb26724',
     armv7l: 'a8e7cee7d0ffe586cff24211d1af56ab47f2a6a2c76b1474a5b5370fccb26724',
       i686: 'd6e16115e7bfec1725975bbe3918bcc40b537a16a6e3cc62cced72008fc8fed4',
     x86_64: 'af376caf56d65504583f8670c929b866e5c82b3fbffe4684ae326e7686812ead'
  })

  depends_on 'brotli'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' # L

  no_source_build
end
