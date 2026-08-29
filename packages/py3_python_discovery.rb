require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5424c56d951586edd6d1832b8b1fa6bfcd15a51c08c7a0f4891f129f149f8863',
     armv7l: '5424c56d951586edd6d1832b8b1fa6bfcd15a51c08c7a0f4891f129f149f8863',
       i686: 'e5bf1b67f53830e8a1c94f46bbab92f89be064e4843a30a71ef0aa9abf2688ee',
     x86_64: '365d10651767a672217e7a128ae2bd281cb9f44b93213be6e14382feedec1a75'
  })

  depends_on 'python3' => :logical

  no_source_build
end
