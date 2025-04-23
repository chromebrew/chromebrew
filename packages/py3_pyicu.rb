require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.15.2-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2eb2134af08bafa8304601a00a5867db500b60aaca01954f6260bac2ad3bf557',
     armv7l: '2eb2134af08bafa8304601a00a5867db500b60aaca01954f6260bac2ad3bf557',
       i686: '9cc8942ed63328635876106dbb78bd829c0bfeca57f819af8cf82486e9a0fc03',
     x86_64: '3fc6859213e55b8c03f241b26fb692c7fb12fad25ea22a06cc7c35e7962c4dec'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R
  depends_on 'icu4c' # R

  no_source_build
end
