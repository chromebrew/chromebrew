# Adapted from Arch Linux python-pylint PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pylint/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_pylint < Pip
  description 'Analyzes Python code looking for bugs and signs of poor quality'
  homepage 'https://pylint.pycqa.org'
  version "4.1.2-#{CREW_PY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca5686b0e5be927816e1536fe56f3de02093e3d86fb7d79a8f85a23b46d38897',
     armv7l: 'ca5686b0e5be927816e1536fe56f3de02093e3d86fb7d79a8f85a23b46d38897',
       i686: 'a66dd6d10639ee5fca4bebcf923ca48de01d81ae313ae5034133be95e485f116',
     x86_64: '079374aecbb87738a3432b549b995bff4ddc4bd22f9b41a62ef95ec2176ad380'
  })

  depends_on 'python3' => :logical

  no_source_build
end
