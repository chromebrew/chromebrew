require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.394-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8fc49504a63e856b9a9777197c56059167ebcb3b9080ab992907472318eb0b4',
     armv7l: 'a8fc49504a63e856b9a9777197c56059167ebcb3b9080ab992907472318eb0b4',
       i686: 'b098d69615f90154858015e91fe081ec9d0d36e1ce1b1062d596333e75323581',
     x86_64: '2881f3b81b55b1d6b45078d1879c7bf22a367f269d5041cfc57041bef13c8734'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
