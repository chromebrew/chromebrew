require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.395-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8fc49504a63e856b9a9777197c56059167ebcb3b9080ab992907472318eb0b4',
     armv7l: 'a8fc49504a63e856b9a9777197c56059167ebcb3b9080ab992907472318eb0b4',
       i686: '2d488d65b6b63481fb236abf1e9365c15f76ad64278656ca9160b955a9ff912b',
     x86_64: '2c297ae48daecd0a82a75eebc797c313fcb6a3fd477971260e8d913ad12ccfd0'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
