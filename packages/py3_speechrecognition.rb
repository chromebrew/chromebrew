require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.14.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e2ac7e2904f047c707c06dbe1b607807a0ee0f0413b548145004c028beb5e6d',
     armv7l: '9e2ac7e2904f047c707c06dbe1b607807a0ee0f0413b548145004c028beb5e6d',
       i686: 'd380a724d7d01c0d71cc608492944b87bc46396f69315b28ee18e276edeba5af',
     x86_64: '283f1230bb95fde9ed02ce194acc81cc87067867cfd07cc563a4de005828f426'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
