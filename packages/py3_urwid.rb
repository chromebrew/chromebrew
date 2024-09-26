require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "2.6.15-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54a5b537a26ed1a5cfa02612ab8dbfa15087a840bfcfd585e3c7bcf88022064c',
     armv7l: '54a5b537a26ed1a5cfa02612ab8dbfa15087a840bfcfd585e3c7bcf88022064c',
       i686: 'fab316e8dc7f7012c792fcdf67985e41dd66bc133349151ef2d922d1112ddda9',
     x86_64: 'aa276be22753a5ef660009116a02ee22219322c08bed3c1264b6900987778dd5'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
