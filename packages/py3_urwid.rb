require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.2.4-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe47dacceefca65083db10356f7fb2b13b64c9655736ae8145c030155b18bd66',
     armv7l: 'fe47dacceefca65083db10356f7fb2b13b64c9655736ae8145c030155b18bd66',
       i686: 'a9b416d223e1ff4c27e36a04ebf2c082c62c59c148c5ca979ff3f2cee7bc6394',
     x86_64: '4505d8e9edc65d9fbbd0475b3a8bdc49adec8d5fae576602d994b9949f319e72'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
