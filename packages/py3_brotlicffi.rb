require 'buildsystems/pip'

class Py3_brotlicffi < Pip
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  version "1.2.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71ab8176581b8d045e49ca292723c5784ca046a48b587745afcd9d39fe9a1042',
     armv7l: '71ab8176581b8d045e49ca292723c5784ca046a48b587745afcd9d39fe9a1042',
       i686: 'bd44fdad8ba60fb368752bbd1e64af2333e5f9973d0f81ae47732467307d9b56',
     x86_64: '30c82a27c53d8d101953e71b1d2e5291ec638f70f6987f12c6b9c8765382f101'
  })

  depends_on 'brotli'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'py3_cffi'
  depends_on 'python3' => :logical

  no_source_build
end
