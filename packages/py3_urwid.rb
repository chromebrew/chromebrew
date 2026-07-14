require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.4-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd4a22d5d214d650609fe09c3e504c84d47b0d354f97029293875ee8aba712be',
     armv7l: 'fd4a22d5d214d650609fe09c3e504c84d47b0d354f97029293875ee8aba712be',
       i686: 'c65908da350063f0c361b0993fd9947d8dc9b5d4e95b45d9161886136906332e',
     x86_64: '6e9e87fbd2961b890ed1a7577be1b1258385f092886c690911bab9abfee3778f'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
