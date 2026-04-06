require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.16.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '699ea482a5e133a809c4b84b64465fba2ce01acc1a80fe5db1bfe3aa5dae60bb',
     armv7l: '699ea482a5e133a809c4b84b64465fba2ce01acc1a80fe5db1bfe3aa5dae60bb',
       i686: 'e0aff4961e02d8830298fdb6e4e229807bcfaab6da31bda0c24b792089562c60',
     x86_64: '9c10cdabbe6c93a19548ac6fd50efa7d4fc57a39d69b925af5755e726d4f4ca3'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
