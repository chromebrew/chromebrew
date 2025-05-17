require 'buildsystems/pip'

class Py3_pluggy < Pip
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  version "1.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e408f381b1f35adb02b11b05cf3b2ffaa2545573445d305d8d473b0c2ab89728',
     armv7l: 'e408f381b1f35adb02b11b05cf3b2ffaa2545573445d305d8d473b0c2ab89728',
       i686: '156b9c4c00e61e4fe24b3863ed301cd090bf56a509f55ca5ca50ccaa33f44850',
     x86_64: '8e14a5746eb128a35d536ce92fd8a5b0ec75a23b0ca7f9c978fe5091d6372d6d'
  })

  depends_on 'python3' => :build

  no_source_build
end
