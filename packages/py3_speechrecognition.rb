require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  @_ver = '3.8.1'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'glibc' # R
  depends_on 'python3' => :build
  no_compile_needed
end
