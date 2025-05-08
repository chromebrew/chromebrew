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
    aarch64: '3ded50ec1306cda310e934707270152a62cee1fd17e5474f341b0631132f6388',
     armv7l: '3ded50ec1306cda310e934707270152a62cee1fd17e5474f341b0631132f6388',
       i686: '29534b324faaa31147b3b369d5c30ea750df33d53165d1f5e393db87b7b54a51',
     x86_64: 'd53b6a491471a3970bf5322285d8d75ccd86688fb1cfb5f217c521cd9a6ad1f7'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
