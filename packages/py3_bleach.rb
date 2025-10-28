# Adapted from Arch Linux python-bleach PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-bleach/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_bleach < Pip
  description 'An easy whitelist-based HTML-sanitizing tool'
  homepage 'https://pypi.org/project/bleach/'
  version '6.3.0'
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9981cef16803a2f3d6eb42f28cbbe512cc9ad9a43a34ea1a817476ae41a2331c',
     armv7l: '9981cef16803a2f3d6eb42f28cbbe512cc9ad9a43a34ea1a817476ae41a2331c',
       i686: '94dd57c3dffb5ccc2c9e49e8e1d81a320405ab925b1c5a14885453cf2c94a130',
     x86_64: '9bc903240420f6c4654c5c667e602f87af8786919c1ba1a5d296b40acc6f08b4'
  })

  depends_on 'python3' # R

  no_source_build
end
