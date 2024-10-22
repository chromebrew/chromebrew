require 'buildsystems/pip'

class Py3_installer < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  version "0.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd03c191d54929c7006aff60e18c0826ce136fa66733d9face8ec43374627e6e1',
     armv7l: 'd03c191d54929c7006aff60e18c0826ce136fa66733d9face8ec43374627e6e1',
       i686: 'ddeaf7fe885b2234af780e7486b07582ad0c1c1ab23597ad6f420db20d55764e',
     x86_64: '72f195913285d7c4fedae3b717d3b862147b9ff0c85fd6acf3286ad7fdd8cedc'
  })

  depends_on 'python3'

  no_source_build
end
