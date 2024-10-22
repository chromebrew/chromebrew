require 'buildsystems/pip'

class Py3_future < Pip
  description 'Future provides clean single-source support for Python 3 and 2.'
  homepage 'https://python-future.org/'
  version "1.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e43861bd9a514fb4842bd2b956348313c3cf8dfb9d992ea4af00a92ee8264afd',
     armv7l: 'e43861bd9a514fb4842bd2b956348313c3cf8dfb9d992ea4af00a92ee8264afd',
       i686: 'e8d8ca661177c5cb22d438e58516fcdf68b8ffe65da3be50e7a3051e244e5a30',
     x86_64: '670fac9bf53098959a130b9a55af63583e419515ecfb769e8a0a18f4460e2c65'
  })

  depends_on 'python3' => :build

  no_source_build
end
