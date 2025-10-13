# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.0.0-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2444716c906e52dd94b0032cf1c8ff36c94b7740ba4f5bcbf1f8fb06066e8a7',
     armv7l: 'e2444716c906e52dd94b0032cf1c8ff36c94b7740ba4f5bcbf1f8fb06066e8a7',
       i686: 'b2727686093c50f9c66d92e503961bd9b102454f9a717e050c7621c7a18fcdae',
     x86_64: '0a56df57c33223c1f03303444473815e8f73bd84fd47b3a00dcc9d865e2386f3'
  })

  depends_on 'python3' # R

  no_source_build
end
