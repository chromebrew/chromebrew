require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2026.5.7.17-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b343b9d118b63b0ae793a8c755dfd8f3d7e5556215ce881cbed3f76f1bd36bdc',
     armv7l: 'b343b9d118b63b0ae793a8c755dfd8f3d7e5556215ce881cbed3f76f1bd36bdc',
       i686: 'eed6153f80f48394a8b3f0849e2e6814e56182c596c34d74d19e24fe75d36dc5',
     x86_64: '70115d0b2f8001d616a58c11efe2aabe68d79218032f29ed097eab1f501acc5f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
