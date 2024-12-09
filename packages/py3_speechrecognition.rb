require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.12.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38dd78105ae5e2fe5de0c4dddc3689738127cacf5c8dadda0d1434785b7a6110',
     armv7l: '38dd78105ae5e2fe5de0c4dddc3689738127cacf5c8dadda0d1434785b7a6110',
       i686: 'e501dcbfcd1e390bd99e014a6c9cec18f5f5ac32e1db2e68530c259a060f5d14',
     x86_64: '1d8e6f05955934f6d87cc9fa4ede8ad9468124de7bfbb157e1e08c6dfc367a52'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
