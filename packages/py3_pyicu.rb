require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.15.3-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f903dd3cd32b5a584ef265598e4e4bb09594ec31818f29f5b06f6586c25e0db',
     armv7l: '5f903dd3cd32b5a584ef265598e4e4bb09594ec31818f29f5b06f6586c25e0db',
       i686: '7a3776d906f6d5b9c0dd13dc4800fe0f1863366ec44e6259ae993d379fc3b338',
     x86_64: '7df8f7442fed573c5be5616f21ed0f36b6825344668d9bbe1a7022b4d1d6f0cc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'python3' # R

  no_source_build
end
