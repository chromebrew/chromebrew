require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.13.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38dd78105ae5e2fe5de0c4dddc3689738127cacf5c8dadda0d1434785b7a6110',
     armv7l: '38dd78105ae5e2fe5de0c4dddc3689738127cacf5c8dadda0d1434785b7a6110',
       i686: '6499c475c7368e3f70e67a4deb01769a9752cd2ce5ffedc4b8a5866185b85442',
     x86_64: '5bf3f9c803c61721e8d14d7decbfd74dd1f24905b8d454255020b236024f5a6e'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
