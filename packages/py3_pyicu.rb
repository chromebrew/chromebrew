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
     x86_64: 'a949345750e28e6f4a51807b82c32e76b866b1101c6c553372cb799165af5b63'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'python3' => :logical

  no_source_build
end
