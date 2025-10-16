# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.1-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ed8fc516b6d097fc77e4bd5a6e7b2cf1a43694effd4010772eef419e62d68e9',
     armv7l: '9ed8fc516b6d097fc77e4bd5a6e7b2cf1a43694effd4010772eef419e62d68e9',
       i686: 'a8f4f00fa6e3ec8526b6c45f4eae0a908c2fedccb8829d81595347b979b15c92',
     x86_64: 'd71f4d4486528798af7f5ea9d634d4244d279be739ea7c2fde28f93b6c684782'
  })

  depends_on 'python3' # R

  no_source_build
end
