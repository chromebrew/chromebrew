require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.10.4-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44c468d13a007c3bb15fcd5c15bb36c7f9c1a83cf22f1386646d526a13023e17',
     armv7l: '44c468d13a007c3bb15fcd5c15bb36c7f9c1a83cf22f1386646d526a13023e17',
       i686: '91406a89933de4752f6578eec5b172fc17979d3447e12c56fbb64b4d7aec9f44',
     x86_64: 'e35b4e6aea32d1b389ceda92dd6f846b51d635d1f6fedd5833191455c0b737c2'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
