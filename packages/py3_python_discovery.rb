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
    aarch64: '8c2482158f278a8aed0a9e7df320a1b26c104d197dc6a99a2531b455699b638f',
     armv7l: '8c2482158f278a8aed0a9e7df320a1b26c104d197dc6a99a2531b455699b638f',
       i686: 'a7364f2380937e415ad8c981ce227d37486a059e9d032f285be93778e52f9408',
     x86_64: 'b863692182b923fed1e71e1e8a1029030358f1028de79b9daf9f1bdf18db5b00'
  })

  depends_on 'python3' => :logical

  no_source_build
end
