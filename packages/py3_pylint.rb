# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.1.3-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e30e51893061660154c821bf69d0bf1432a952ce78835f647479f4d4d4140f8',
     armv7l: '7e30e51893061660154c821bf69d0bf1432a952ce78835f647479f4d4d4140f8',
       i686: '8810e24ee2589ef3e94f512a1773c473bbb0f48457155d04e616d00a6f67184e',
     x86_64: '0987ba0c24424eab26233ca2c3583fd8538f3a31ca7034294c7faebb28b7af30'
  })

  depends_on 'python3' => :logical

  no_source_build
end
