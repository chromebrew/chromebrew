require 'buildsystems/pip'

class Py3_imapclient < Pip
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  version "4.0.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7037a6b08d0d2c80b831faf8b15916f61ab3c8008bfa7e6ae16eb0c301c491f',
     armv7l: 'b7037a6b08d0d2c80b831faf8b15916f61ab3c8008bfa7e6ae16eb0c301c491f',
       i686: '25f5c92f55a8b515831cc10111d6d5ae1a914c64dfa4b544b24a4f142d425bbf',
     x86_64: '347d7b7d2646378866f06fd39d4e833a51c64da389a1158fa03b3fd0adb24f6e'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
