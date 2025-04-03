require 'buildsystems/autotools'

class Libidn2 < Autotools
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  version '2.3.8'
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libidn/libidn2-#{version}.tar.gz"
  source_sha256 '93caba72b4e051d1f8d4f5a076ab63c99b77faee019b72b9783b267986dbb45f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'adbffb0615f7f292642ef4b6b279ebe8f4f588e931b10aa804aa29faf6054857',
     armv7l: 'adbffb0615f7f292642ef4b6b279ebe8f4f588e931b10aa804aa29faf6054857',
       i686: '7f8924f7edd7ea1f6e61052ca7104e59d2e84fd1d066d76e36f795562dfdc73f',
     x86_64: 'c52ce4eb1cdd80d6cd9bbe5df1c212b21e51d076ec23b6c443e25d76e62cb515'
  })

  depends_on 'glibc' # R
  depends_on 'libunistring' # R
end
