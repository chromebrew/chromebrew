# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "3.3.8-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8332d1c509c7e69a5a7606ed4d47e9bd5de0ba3ed0d10422ad0b7600754e3b9',
     armv7l: 'd8332d1c509c7e69a5a7606ed4d47e9bd5de0ba3ed0d10422ad0b7600754e3b9',
       i686: '89863b2ceed45642861e1fe8574cd56b017e770dc0728e44c00cd2a14bf8cc6e',
     x86_64: '33a273dfcbc1aec8997b19d4b83bddc8e9923f1bd35b25cd32dd7da1a375e833'
  })

  depends_on 'python3' # R

  no_source_build
end
