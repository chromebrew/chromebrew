require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2024.10.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72f55bf7d257224d29f30ebedf6803736de21d0025a366264831e573bd51b03f',
     armv7l: '72f55bf7d257224d29f30ebedf6803736de21d0025a366264831e573bd51b03f',
       i686: '4f2c173e829513672fbf85389d2c499bd602c5f949153610434d7ca1dcb0b2f7',
     x86_64: '745b76997903e68f6aa03ad87ab8fd1bc52fa5f366db04a8c90278aa7f9939c1'
  })

  depends_on 'python3' => :build

  no_source_build
end
