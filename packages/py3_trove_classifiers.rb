require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2026.1.12.15-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '579afd0ba00c0b12d771ae196cfec29649e77864f5340c46eb70dc04c4065bb6',
     armv7l: '579afd0ba00c0b12d771ae196cfec29649e77864f5340c46eb70dc04c4065bb6',
       i686: 'a9ae2e86de0297a0b21442cb5212a557c4b0868f902cdcbb256962c9963163af',
     x86_64: '63ee136697348cee6c9ef4e968dcae4f25c6de6fec8c80d95b2bff0846ccb3b5'
  })

  depends_on 'python3' => :build

  no_source_build
end
