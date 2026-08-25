require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.5.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c992eb01950dfff64d34e4f23c572547335219c1bfb3006ced63b422bd51c3b',
     armv7l: '9c992eb01950dfff64d34e4f23c572547335219c1bfb3006ced63b422bd51c3b',
       i686: '8c650207d5aaa0ddfd2949cce8e131e8fdb8bed6226229b7a730b93d1f067f9c',
     x86_64: 'aabaa99954784114025c959030f5a6ef89fba8f42dd15770b8dc3125106c41ac'
  })

  depends_on 'python3' => :logical

  no_source_build
end
