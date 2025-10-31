# Adapted from Arch Linux python-mdurl PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-mdurl/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_mdurl < Pip
  description 'URL utilities for markdown-it'
  homepage 'https://github.com/executablebooks/mdurl'
  version '0.1.2'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02aa3ecbd424f2e35bfdb65ff1e858168f6cc8c29b7875ee71566b2991bcf5cc',
     armv7l: '02aa3ecbd424f2e35bfdb65ff1e858168f6cc8c29b7875ee71566b2991bcf5cc',
       i686: '0f2a77969cee945ebc1b0ba552bbb9b9307f3c63b05937fedbff629cf9a21bca',
     x86_64: '0c9f732ba4a5d965e103a27edeeb118d5c5eea5ea1c74958ee16cffa59fbc1b3'
  })

  depends_on 'py3_uc_micro_py'
  depends_on 'python3' => :build

  no_source_build
end
