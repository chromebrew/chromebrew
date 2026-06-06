# Adapted from Arch Linux python-bleach PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-bleach/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_bleach < Pip
  description 'An easy whitelist-based HTML-sanitizing tool'
  homepage 'https://pypi.org/project/bleach/'
  version '6.4.0'
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf920549e889d028f8d1ef34d676aa459b563ec929947504f697e98736231d4d',
     armv7l: 'cf920549e889d028f8d1ef34d676aa459b563ec929947504f697e98736231d4d',
       i686: '429996f9ac1fd0be7b4a2906833b0cd1acb9f2d1b160fde3bebebe439328246e',
     x86_64: '9e7ee8f4ef59dfe4d20a976cdb266237061f41e6abd9a5a18d0527280818d4a0'
  })

  depends_on 'python3' => :logical

  no_source_build
end
