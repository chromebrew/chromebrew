require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2026.4.28.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d67014a10aa7bfcc12713af4ada7d23e5753beefeebcdc2d8081427116a32bc',
     armv7l: '9d67014a10aa7bfcc12713af4ada7d23e5753beefeebcdc2d8081427116a32bc',
       i686: '7ae690267b40e7528cd3f6ad283831af9a46607c777a05f75d4cc549edbcd138',
     x86_64: 'a4e3833811d5dd8738188e07af5bade07ae6af1e1a53f6b1905ec682047e81ce'
  })

  depends_on 'python3' => :logical

  no_source_build
end
