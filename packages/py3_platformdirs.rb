require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.3.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1734f3a4add0842a45e869398092fae61e54f4f905ffed6162974f2f9770181',
     armv7l: 'f1734f3a4add0842a45e869398092fae61e54f4f905ffed6162974f2f9770181',
       i686: 'd0856f1804c947f41db8594590a056a7239e7b8ef446cdc40a1f43aa2fb2a42a',
     x86_64: '260ed463614eed3ca9a6b00a2c5f6badeb9c94b3083c37c17ce105a8bc513c32'
  })

  depends_on 'python3' => :build

  no_source_build
end
