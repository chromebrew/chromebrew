require 'buildsystems/autotools'

class Autoconf_archive < Autotools
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2023.02.20'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-#{version}.tar.xz"
  source_sha256 'e07454f00d8cae7907bed42d0747798927809947684d94c37207a4d63a32f423'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '538076c9589edd796a25e62ddce771d92169db79179ed32755dc2eee0717ea3d',
     armv7l: '538076c9589edd796a25e62ddce771d92169db79179ed32755dc2eee0717ea3d',
       i686: '9c0c8fc457fe4d79ca1e5d12f51122c984ac5c3c2dfa07a8ef06bc0df32623be',
     x86_64: '7729228006a55364e4dad960a9ff78e32cd3675cbdbde1960fe6f676b06f5846'
  })
end
