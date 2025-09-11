# Adapted from Arch Linux python-bleach PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-bleach/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_bleach < Pip
  description 'An easy whitelist-based HTML-sanitizing tool'
  homepage 'https://pypi.org/project/bleach/'
  version '6.2.0'
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df557e12ef5e2f8abdf74e38135e3b3c38ac3f24fc9bd999cbae77db40bdee94',
     armv7l: 'df557e12ef5e2f8abdf74e38135e3b3c38ac3f24fc9bd999cbae77db40bdee94',
       i686: '1a85d2dd86282a266ee90f9e04d196572e21a9495bee6e241c52e5dd9074094f',
     x86_64: '8a5b0b03d9afc652571b1a1e4896d5956ceebd5c3c5d77d4166c6e916399ebc9'
  })

  depends_on 'python3' # R

  no_source_build
end
