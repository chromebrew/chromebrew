require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.9.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5bf2aab6a87f879c69965be97a3b2e610c6a31bc389c03214fc3ce46d430a56',
     armv7l: 'a5bf2aab6a87f879c69965be97a3b2e610c6a31bc389c03214fc3ce46d430a56',
       i686: '0c8d69446e8b0cfd148e65e9eb031ae0303eb3d4abaf1a522e4bf0176c3a62aa',
     x86_64: 'dea25240a400aa4aa49c49b484a6fb71d7efce5a760795a5abfa3fd994fe56be'
  })

  depends_on 'python3' => :logical

  no_source_build
end
