require 'buildsystems/meson'

class Desktop_file_utils < Meson
  description 'contains a few command line utilities for working with desktop entries'
  homepage 'https://www.freedesktop.org/wiki/Software/desktop-file-utils/'
  version '0.28'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-#{version}.tar.xz"
  source_sha256 '4401d4e231d842c2de8242395a74a395ca468cd96f5f610d822df33594898a70'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4636562db608cd98f38e7530aaab24ee25d981cdd3e422a7544ef43f144bce1c',
     armv7l: '4636562db608cd98f38e7530aaab24ee25d981cdd3e422a7544ef43f144bce1c',
       i686: 'ccb2e816dcfa5a0d3799803e3272930aca874ed7192fa7966b234fac5aed03ab',
     x86_64: '698217eb99f78f60dc28b521e0a3c7d386fee477ce323e2eff1a758c6dfb9f49'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
end
