# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "3.3.3-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc72c346b3524a5004d55ba2f438c7e315f092d52fa323ba1bdafd8166fe4c44',
     armv7l: 'dc72c346b3524a5004d55ba2f438c7e315f092d52fa323ba1bdafd8166fe4c44',
       i686: 'fcf73c2542b8a00f872eb4aaccd9b9a480afbd24bf8c2766ac3e96f41b22fc0b',
     x86_64: 'cf712d37bd0bb247a56f99662399a0e6dc1efb6b5795585f71fd959dda77e776'
  })

  depends_on 'python3' # R

  no_source_build
end
