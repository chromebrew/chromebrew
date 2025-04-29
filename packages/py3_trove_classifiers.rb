require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.4.28.22-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b3e77f41abb615372ba1c0b3663fe09ee299c6f12f45ef4bd57290c6f86e6b2',
     armv7l: '0b3e77f41abb615372ba1c0b3663fe09ee299c6f12f45ef4bd57290c6f86e6b2',
       i686: '72d64671cd9fe392875f5ac6b89ffc06f80c669665b9d19d652045eb0312f511',
     x86_64: 'e38d6b74de4bd95dc545eed6f7cafe79f76ebcd363322ab096ee153cc950155a'
  })

  depends_on 'python3' => :build

  no_source_build
end
