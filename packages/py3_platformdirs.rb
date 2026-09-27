require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.12.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4af6262cbd23b8497551b110ec630d4fb2efc9dd1e2372b573de6a2e37408d2',
     armv7l: 'd4af6262cbd23b8497551b110ec630d4fb2efc9dd1e2372b573de6a2e37408d2',
       i686: '39ec6e80811d097d1af3449399221c51177a268da6e03a22e51907e98b442f1f',
     x86_64: '0a4445e0e8666377ca748e921a683ce92c5d7ec21832d76c006a44edcbd69538'
  })

  depends_on 'python3' => :logical

  no_source_build
end
