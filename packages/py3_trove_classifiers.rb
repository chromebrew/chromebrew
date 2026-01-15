require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2026.1.14.14-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac5a8e54c4ec57fcf8717dd5a5d2220bbe88e2147b0a601e37e43fee3cc1ca69',
     armv7l: 'ac5a8e54c4ec57fcf8717dd5a5d2220bbe88e2147b0a601e37e43fee3cc1ca69',
       i686: '67d1a1cef827f6b836ccbdda610e60df6814bc9dce784ee24cff94cb35f3a368',
     x86_64: 'f2fb2f35afa68332f249c798c2bd2f889dffe07c690e247e27de485a2325828c'
  })

  depends_on 'python3' => :build

  no_source_build
end
