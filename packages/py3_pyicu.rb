require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.15-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1687559391663ccf719a892525774196e52b04fc70fb6523f7578765772a0240',
     armv7l: '1687559391663ccf719a892525774196e52b04fc70fb6523f7578765772a0240',
       i686: 'd1e1cbf1d29e0a0013075f788d9173e6dc9686ffa0ed968218ab4007503fce79',
     x86_64: '0f288bde104ee243259eceb962383823d1a6e034beb081962bab7aec0dd418d4'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R
  depends_on 'icu4c' # R

  no_source_build
end
