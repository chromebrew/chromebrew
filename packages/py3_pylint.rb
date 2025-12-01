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
    aarch64: '8538bd25160da65ac629ed8062c50825de98a7acf2547c4a4493d9ae797293ec',
     armv7l: '8538bd25160da65ac629ed8062c50825de98a7acf2547c4a4493d9ae797293ec',
       i686: '4f8b622c2fe0d32265e7f7956cce962a91c7865261a281898ec181fe9fa1e750',
     x86_64: '62eb663f5db47e7ac242bd0173fc340ad232d6d7e4fcd238d8167c16da16173f'
  })

  depends_on 'python3' # R

  no_source_build
end
