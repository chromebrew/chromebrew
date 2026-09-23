require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3873ae2840dbe740096471f0ef083fbae1bd62e54d9a36d4d485a26c6e751d3d',
     armv7l: '3873ae2840dbe740096471f0ef083fbae1bd62e54d9a36d4d485a26c6e751d3d',
       i686: 'e7381dc23ece9cf324bda7538dd8311d87ef2ce78075175192e951b6de63471c',
     x86_64: 'ee61d87fe80e0b162adf6e80b1d0e950116f141076b7fbc230e011b1c3d9780e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
