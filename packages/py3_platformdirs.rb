require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce087d025b57c7b684b1498c902fb2caaca8482fe78bc0d839c62150411c6bb0',
     armv7l: 'ce087d025b57c7b684b1498c902fb2caaca8482fe78bc0d839c62150411c6bb0',
       i686: 'ad553188e700b0bd3bb0fa7ce9d15a643a31766c3d8d6e28be9f553250159fb5',
     x86_64: 'db7bb85dd2f0c4d751328669037fe1a2aacf966da718a67986ca342c6ccfd7a2'
  })

  depends_on 'python3' => :logical

  no_source_build
end
