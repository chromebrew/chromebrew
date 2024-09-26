require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.13.1-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6eae174f9c3871644bbe8ec5792ef7cb49c4a353d1c62cce78c438d9a67a9a89',
     armv7l: '6eae174f9c3871644bbe8ec5792ef7cb49c4a353d1c62cce78c438d9a67a9a89',
       i686: '5d4a05e038508cbcef7596c40b32ab739d81243636f0c60d290a920da0cf1952',
     x86_64: '3dd41517151950f5cf13625035e0511b40c85cfb47b7be41df7dd3827ad3b8a6'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R
  depends_on 'icu4c' # R

  no_source_build
end
