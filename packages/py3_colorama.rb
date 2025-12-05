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
    aarch64: 'de2bcf3becb719707b2c4c1ce3715a7c020d9a18f81053ae480aaf64ac364924',
     armv7l: 'de2bcf3becb719707b2c4c1ce3715a7c020d9a18f81053ae480aaf64ac364924',
       i686: 'be7303cbb39cd8b741e5311d95d6628881a2471c40efb1c2193f83667fdfa996',
     x86_64: '85fd98c9105015143457c3464f92fb691930d48d8c40c316b929ce9b6fa056b2'
  })

  depends_on 'python3' => :build

  no_source_build
end
