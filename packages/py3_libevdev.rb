require 'buildsystems/pip'

class Py3_libevdev < Pip
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://python-libevdev.readthedocs.io/'
  version "0.13.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e07ac43415cb9bda35312628c60db8f18d4215a283df3f47a3ab95cdf4d9add4',
     armv7l: 'e07ac43415cb9bda35312628c60db8f18d4215a283df3f47a3ab95cdf4d9add4',
       i686: 'ee52a4a09e5f6ee95c2c1ba3c2a05d88a888dcdfe5d0f804d0bbb2e6e0da051b',
     x86_64: '3bdf6dc8630d8e483c6a36a69f71598af40a86bbf3614d45269824f7851434b4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
