require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.14.5-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72a07ea5af2ef1b9f5be59d98f4dfce6de8fc7597de515d0378638aaccceb445',
     armv7l: '72a07ea5af2ef1b9f5be59d98f4dfce6de8fc7597de515d0378638aaccceb445',
       i686: '1937266f360353285fb3c951c2a8dd8d6eb7a04e8758b1bb25727a9ac82983c6',
     x86_64: '442b2e512a071ae92f6e2fd85638608fcd6ebdde599f734fce9287a1418e8fdc'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
