require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.11.12-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd23bea38e7eeb168cd69f9ec36d26c5d9761a6ed6d0865c8cb94ba39f087d554',
     armv7l: 'd23bea38e7eeb168cd69f9ec36d26c5d9761a6ed6d0865c8cb94ba39f087d554',
       i686: '38eb520c53f133a55893bd1cb5ead3c7464e4de28a3da7c651fb174bf24b7106',
     x86_64: '18f3d01219f69f10a9d3285c78ed3f32762c61a7cdbce420e307986752d322da'
  })

  depends_on 'python3' # L

  no_source_build
end
