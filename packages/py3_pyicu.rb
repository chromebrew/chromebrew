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
    aarch64: '094de990266995c949412967d40e263bebd3f829ffb6d948d3c2829c80afcbf3',
     armv7l: '094de990266995c949412967d40e263bebd3f829ffb6d948d3c2829c80afcbf3',
       i686: 'ec0a894913ac712785a7e18882777c5cc4205d8feffafba6dd57142224566f37',
     x86_64: '5a90e33b5810adf82b1a7828aa27ea18ce0daca55f17b7d75ab0a57e8b30cf6e'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'python3' => :logical

  no_source_build
end
