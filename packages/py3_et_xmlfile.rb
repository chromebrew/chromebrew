require 'buildsystems/pip'

class Py3_et_xmlfile < Pip
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://foss.heptapod.net/openpyxl/et_xmlfile'
  version "2.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3aff56dc7cad9665a375591a948a186a16271ab6145b70507d5997e518e499cf',
     armv7l: '3aff56dc7cad9665a375591a948a186a16271ab6145b70507d5997e518e499cf',
       i686: '7e460b9316d47a20b7f950d597eff8dd3abd20c6089a4ea02deba13e7e3e5929',
     x86_64: '6af8817749ec355bf5e71df6282bf146eec18d0e4bfb0cc8dfbc4552806b2a30'
  })

  depends_on 'python3' => :build

  no_source_build
end
