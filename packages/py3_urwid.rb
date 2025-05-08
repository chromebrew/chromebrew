require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "3.0.2-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3a85ed7d90f0ca1dca9808a291859221661b62f3501ec4da972f71f11a5118a',
     armv7l: 'f3a85ed7d90f0ca1dca9808a291859221661b62f3501ec4da972f71f11a5118a',
       i686: '944ce3812ee30f90a54422cbfa3eefccede3679bea06fbed0123456b4bfa0d6b',
     x86_64: '40f114dbfa93b0f074291e731e5251e0ba77dbf4d7e70b77a7ade3e0bea9d7c7'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
