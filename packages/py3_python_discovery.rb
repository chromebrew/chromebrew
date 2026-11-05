require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.9.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69b993137333b70660e70046cf282e9183fa00ebc55de7d775e8af8d9e086f0e',
     armv7l: '69b993137333b70660e70046cf282e9183fa00ebc55de7d775e8af8d9e086f0e',
       i686: 'd5ffcadacbef298741f9f3291e8f048e1a2be75eb60f89497f9e583f26dc2447',
     x86_64: 'e9becfddea14fab3ddf0e7fd79db1c56c90b6f41bfb2de62b99a763d0bc8b39e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
