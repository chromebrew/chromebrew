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
    aarch64: 'beec6e3745de54a740f2b478b11e2ccd4fa15f2da928ab854f50581cb0623983',
     armv7l: 'beec6e3745de54a740f2b478b11e2ccd4fa15f2da928ab854f50581cb0623983',
       i686: '7f8924f7edd7ea1f6e61052ca7104e59d2e84fd1d066d76e36f795562dfdc73f',
     x86_64: '1d57e7b2d3438cb1a912506621938bc7140876b9cf4e1b54f07c0761851aca98'
  })

  depends_on 'glibc' # R
  depends_on 'libunistring' # R
end
