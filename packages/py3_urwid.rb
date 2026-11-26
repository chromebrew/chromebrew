require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "5.2.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19c3f9705250c5124574a238a5010d278f97b64309a75b8b8b4e315d744d68cd',
     armv7l: '19c3f9705250c5124574a238a5010d278f97b64309a75b8b8b4e315d744d68cd',
       i686: '28ca1878dec2204f72872d5eb987b0a71dc2387814a61c017f5c69cec3915761',
     x86_64: 'b3b64184583e5c233dd52b54a2079ebd59520fcf788652047ac7e4d8bb4b0c4f'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
