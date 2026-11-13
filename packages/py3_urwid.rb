require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "5.1.3-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02fe0a1340684306b99a114ecf2cb34dfdc1e8102bcb75380ee8183e48265d72',
     armv7l: '02fe0a1340684306b99a114ecf2cb34dfdc1e8102bcb75380ee8183e48265d72',
       i686: '6e169da5aff7800c89a8d3d2add59da50629639583f4b8aa7940dbc51484f5eb',
     x86_64: '4d743dcdae513f983af5c77e44656e200bb072bd868515542e1f9783fa609bab'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
