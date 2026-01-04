require 'buildsystems/pip'

class Py3_speechrecognition < Pip
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  version "3.14.5-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa59b1922c620298fda2517323e3a4a55d36e48362b5948edfac2ddefcd0ca54',
     armv7l: 'aa59b1922c620298fda2517323e3a4a55d36e48362b5948edfac2ddefcd0ca54',
       i686: '282ac005a527a601898d9d8c50d5ba5ec74dfdf0ee4548b2a225d1cfd64c2bd6',
     x86_64: '3be30481e7aefcb7fa18c4fdf4527d4d5ff94439b2ed8d07e16fc6eee9b2838a'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
