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
    aarch64: '16022957e814160c4f35902e6b61269aab39bb0c68390f9d2a277b981ed626f6',
     armv7l: '16022957e814160c4f35902e6b61269aab39bb0c68390f9d2a277b981ed626f6',
       i686: '670e2d1914c1579d4eec01a987d6e19ee550d02f2845196cfe2d64c072e766c2',
     x86_64: '5bf3f9c803c61721e8d14d7decbfd74dd1f24905b8d454255020b236024f5a6e'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
