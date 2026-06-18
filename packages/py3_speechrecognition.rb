require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.17.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73a112ce879795ddc0a28c482ad0baba99ddef525682bf91c5ff625b9c55fbad',
     armv7l: '73a112ce879795ddc0a28c482ad0baba99ddef525682bf91c5ff625b9c55fbad',
       i686: '0c4844e298239b9ba65eeef142a896f748f2ff0d894047406d20f7a72c7cad3c',
     x86_64: '2c9a9af176a9f19ec5452d1fbcaba3c00396f526dcbd4602df4a92dd3293e765'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'python3' => :logical

  no_source_build
end
