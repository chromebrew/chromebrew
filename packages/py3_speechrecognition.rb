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
    aarch64: '8b20f5e11ca62f9ea532169d6140e5976c6919a3fc87c3dc0079b9688c46d23a',
     armv7l: '8b20f5e11ca62f9ea532169d6140e5976c6919a3fc87c3dc0079b9688c46d23a',
       i686: '4cafc939b6fe0be007a0e08a71165def7ead007ed9df972f1fb38cd822dfbcd1',
     x86_64: 'c7299a9a6857b79492e2f20ed483f11ed01b2b888b03e9fd1d355705adba099b'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
