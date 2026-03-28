require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.16.2-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4be754dc64669a424a5a7f11a44ec124c5fd06dbacf2da72c8ee4c5b0574128',
     armv7l: 'a4be754dc64669a424a5a7f11a44ec124c5fd06dbacf2da72c8ee4c5b0574128',
       i686: '77cd37ecbbf0117e13549481228046e2b9252798ddd5a4974c0286c5f6d3641a',
     x86_64: '5a90e33b5810adf82b1a7828aa27ea18ce0daca55f17b7d75ab0a57e8b30cf6e'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'python3' => :logical

  no_source_build
end
