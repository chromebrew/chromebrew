require 'buildsystems/pip'

class Py3_mutagen < Pip
  description 'Python module for handling audio metadata'
  homepage 'https://mutagen.readthedocs.io/'
  version '1.47.0-py3.12'
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56491f1ec418da55e3d9644fdf9ef7e3585093b4f5d692446c2ca4ae242cce1c',
     armv7l: '56491f1ec418da55e3d9644fdf9ef7e3585093b4f5d692446c2ca4ae242cce1c',
       i686: 'f5bc47e601448e473183be5db4f9751224935fd9f610b4cfc99fdefcc94c471d',
     x86_64: '7abb4402d1172c70290d144812ebd1fe350f38b988fe6d13d642496e89b6a2fa'
  })

  depends_on 'python3' # L

  no_source_build
end
