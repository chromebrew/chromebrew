require 'buildsystems/pip'

class Py3_colorama < Pip
  description 'Colorama makes ANSI color sequences work on MS Windows.'
  homepage 'https://github.com/tartley/colorama/'
  version "0.4.6-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '473273ff6fa3077b4e06f2f71e33afddca8cc3ba4320eb233e14586e0275a839',
     armv7l: '473273ff6fa3077b4e06f2f71e33afddca8cc3ba4320eb233e14586e0275a839',
       i686: '6bce6bfa08b9c21c954177b9ee03887b51c7b5133bf1e690896b0e549445361b',
     x86_64: '6dfd9a5a1dfe71424df2c0bc1e1c6bf95e355cb8cd6f29ddfd9fa291f5f16db1'
  })

  depends_on 'python3' => :build

  no_source_build
end
