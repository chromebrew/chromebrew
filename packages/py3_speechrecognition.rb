require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.14.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c31922e8828c7bde96089bfc19bca48c16901534b42199ca9130799b9030071',
     armv7l: '9c31922e8828c7bde96089bfc19bca48c16901534b42199ca9130799b9030071',
       i686: 'ab4da9b94946de08c7bd00b5fbd416ac1518aad6ea870487f28df0a55f0aa7a5',
     x86_64: '58435dba4a2d085bdc55bb59e0d98e6aab21b4c23079f8fef6ec19ad0a8325a5'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
