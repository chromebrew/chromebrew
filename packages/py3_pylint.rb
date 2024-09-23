# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version '3.3.0-py3.12'
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2e1ddbf4bae2387f9e13bc160b06cc090ae34550c3e3aaa9d797cbb98a21269',
     armv7l: 'f2e1ddbf4bae2387f9e13bc160b06cc090ae34550c3e3aaa9d797cbb98a21269',
       i686: 'aa9019627be383c6ffbd2effb7f2accf9d9b0a2fe1b5a104ea4727219a0eb133',
     x86_64: 'a5c52e55368b3d2ddf44c0fa1944db2a53ee00dc54a6a24739c2ce25fafcbaea'
  })

  depends_on 'python3' # R

  no_source_build
end
