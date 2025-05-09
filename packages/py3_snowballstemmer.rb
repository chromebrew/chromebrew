require 'buildsystems/pip'

class Py3_snowballstemmer < Pip
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  version "3.0.0.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b9afeff6ab67e3c38e834cca86dcfe04f4fa950ec2a8e54bad717b70c1ff704',
     armv7l: '0b9afeff6ab67e3c38e834cca86dcfe04f4fa950ec2a8e54bad717b70c1ff704',
       i686: '1dded22e1ca04a3ec5f453a3d0f4dbf9197b14303cd880596190a29a16d95ad2',
     x86_64: '6edb97dcbfb3afe436dc8b595fb73e1ee5893970240c2db3328a2edc41fef20e'
  })

  depends_on 'py3_pystemmer'
  depends_on 'python3'

  no_source_build
end
