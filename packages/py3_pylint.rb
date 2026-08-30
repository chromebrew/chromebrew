# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.8-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bbf3bf1f56c60bfc8de5b6eb94fcac836e25157f14e51458f93cec1be9fc24c7',
     armv7l: 'bbf3bf1f56c60bfc8de5b6eb94fcac836e25157f14e51458f93cec1be9fc24c7',
       i686: '8aeb54d32989afc2cf20b3508bce04ec5a13e72d27c7082585e153b08fa21567',
     x86_64: '3510292f52ea8c57f3078e0e1baa19a19697b483537c1fa65bbc085f2458a2a6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
