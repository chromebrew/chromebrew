require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.14.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c31922e8828c7bde96089bfc19bca48c16901534b42199ca9130799b9030071',
     armv7l: '9c31922e8828c7bde96089bfc19bca48c16901534b42199ca9130799b9030071',
       i686: '670e2d1914c1579d4eec01a987d6e19ee550d02f2845196cfe2d64c072e766c2',
     x86_64: '58435dba4a2d085bdc55bb59e0d98e6aab21b4c23079f8fef6ec19ad0a8325a5'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
