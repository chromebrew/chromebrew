# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.4-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b420597513a1fcc158f5e2b0dbf85b4b51c410db08180c6a2c9bcd07388153f',
     armv7l: '8b420597513a1fcc158f5e2b0dbf85b4b51c410db08180c6a2c9bcd07388153f',
       i686: 'ff8b24182d45732fe190ad1e60ea4690a4167af0d0395bc1b5db527e853dde7e',
     x86_64: '3e62d32e0ccb98d975cbed11aec1fc39327f75eae7a6780b066687207bdba1d3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
