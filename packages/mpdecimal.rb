# Adapted from Arch Linux mpdecimal PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/mpdecimal/trunk/PKGBUILD

require 'buildsystems/autotools'

class Mpdecimal < Autotools
  description 'Package for correctly-rounded arbitrary precision decimal floating point arithmetic'
  homepage 'https://www.bytereef.org/mpdecimal/index.html'
  version '4.0.1'
  license 'BSD'
  compatibility 'all'
  source_url "https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-#{version}.tar.gz"
  source_sha256 '96d33abb4bb0070c7be0fed4246cd38416188325f820468214471938545b1ac8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e995ff521db72f576566f4b7b9d9a5e4474be854a4e9d5177872b2185dc4ccbe',
     armv7l: 'e995ff521db72f576566f4b7b9d9a5e4474be854a4e9d5177872b2185dc4ccbe',
       i686: '683d89e09f6826a1ee6c70cdafa00e5fbd5fe6cc472b8141afb8f6dd989aba9d',
     x86_64: '9eeeca2110c6be8a862f76d81910e070b60502d3542cc24842422b771b5292fd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
