require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.4.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb12b13783039b4c1b14e9a0359b0536273af29726cca024b838ae56cdf33fe1',
     armv7l: 'fb12b13783039b4c1b14e9a0359b0536273af29726cca024b838ae56cdf33fe1',
       i686: '0be3a615d9e2f5b987d368a0e259e0301e9ea62ef99258de4c6b384d3d500f13',
     x86_64: 'f03723002b25e465c93fdc8d1e3f787858aea433d5ee66b91b23338bae4a39a4'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
