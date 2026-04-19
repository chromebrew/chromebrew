require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.3.11-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c9d1f053a4926580efc9b04e0f0562eddfa86355ebc36cf60aff21ae7a153db',
     armv7l: '6c9d1f053a4926580efc9b04e0f0562eddfa86355ebc36cf60aff21ae7a153db',
       i686: 'f36a72da2ce3b975231a3f3140bb7220d03220940b2515ec5abe0c9eba87b783',
     x86_64: '2b021c99b3d9897270cf89e0eec1d63b330fc3a52096539eb676750fc86813f0'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :logical

  no_source_build
end
