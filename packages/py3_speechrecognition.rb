require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.16.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd91c17b5a1beba802226d300a039de4426d7a3488ddf08fbf9023f20aa1701f3',
     armv7l: 'd91c17b5a1beba802226d300a039de4426d7a3488ddf08fbf9023f20aa1701f3',
       i686: '8d24105ad0a1b71dc724270f13d0f47d5cb7fb37db72b366de7a630b011e8524',
     x86_64: '862012ce3cbc0808631d7e6b1fd79b6d22df474d5e1580556d0763b99e8c06b8'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
