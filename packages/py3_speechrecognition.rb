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
       i686: '203a5c5e251acf18748f34557cc58b4b55afcb59b6f3f5e4794c8daec988eab5',
     x86_64: '37dbe1bdf768997f5150ce208329b98ab77927723b6f19e7486769fb08ba9642'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
