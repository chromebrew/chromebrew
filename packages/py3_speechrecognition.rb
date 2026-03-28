require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.15.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e3ebe04fe71fc5c0bee1ff53bdae4f16b37ea58b71fe96d43f336fb85a8717e',
     armv7l: '7e3ebe04fe71fc5c0bee1ff53bdae4f16b37ea58b71fe96d43f336fb85a8717e',
       i686: '6bcb0a32fa0c7822ac24562cc90cdf269a4673b56ebd34b269e670f35f125403',
     x86_64: '42fe84f890c268ee72c2063d88aad9c7a676632fff20295587f0eca66c5c398c'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
