require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.14-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1bd7f2b6ad53c7d6b9b49a81bce6fd7ea7b1340b1972c037c0c024c86dad137f',
     armv7l: '1bd7f2b6ad53c7d6b9b49a81bce6fd7ea7b1340b1972c037c0c024c86dad137f',
       i686: '161777426ef5031a0a05b1814ffe9981c434e5e78cdc6e1da6b05f5a4b361384',
     x86_64: '2edcf17c5c465084f675af4792f7652adcec19ccc5197057fe6b6932a57e5871'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R
  depends_on 'icu4c' # R

  no_source_build
end
