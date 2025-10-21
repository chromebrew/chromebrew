# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.2-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ade1470e3a5547c9e829c6bd680ebfb84d98968eb91b41917a1e2b696e8daaf',
     armv7l: '9ade1470e3a5547c9e829c6bd680ebfb84d98968eb91b41917a1e2b696e8daaf',
       i686: '57f56c603ef750e6b4869d872a5e2d853d8cc125b5171a540c69d8eff5ac2a91',
     x86_64: '748a970b19cf77c0d874d052f585bed2470f8d161d5dc4c6b6aaeddc4026f97e'
  })

  depends_on 'python3' # R

  no_source_build
end
