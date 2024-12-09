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
    aarch64: '126080b3ed5daf57f85faae07a532d6a5c275b750dbad3868216cbe0db014361',
     armv7l: '126080b3ed5daf57f85faae07a532d6a5c275b750dbad3868216cbe0db014361',
       i686: 'ac6ff09bc0935f4ef955ac70056cf5beade710a8fc2a37ea17b86734e0b483de',
     x86_64: 'cafaebb85c7282ddb66111199d3c2ef9f941bf72e06e7732dafde04b35f0e424'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
