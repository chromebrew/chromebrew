require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.14.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7799c76d617998766d73c4eaa73e9768663e6888cb5721548dd9a3f76165a4ec',
     armv7l: '7799c76d617998766d73c4eaa73e9768663e6888cb5721548dd9a3f76165a4ec',
       i686: 'ab4da9b94946de08c7bd00b5fbd416ac1518aad6ea870487f28df0a55f0aa7a5',
     x86_64: '50ba9f7b1c77d6e645e180e28c9d18fa00b148cb0d4ef291d3f43cc5fc190b31'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
