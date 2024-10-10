require 'buildsystems/pip'

class Py3_hatch_vcs < Pip
  description 'A plugin for Hatch that uses your preferred version control system.'
  homepage 'https://github.com/ofek/hatch-vcs'
  version "0.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1dd39998699dba2d1b9494a53088aeabc9cd1322f457798960571594bbd9ec4f',
     armv7l: '1dd39998699dba2d1b9494a53088aeabc9cd1322f457798960571594bbd9ec4f',
       i686: '6b61d1fd8009ee31385f4490a149da3d5c4a011335b329ce475fdc7e6c7dc255',
     x86_64: 'dcda4092125f740ad5f31bf2cc931dde758d17dcc45abead903a1efd91feac11'
  })

  depends_on 'python3' => :build

  no_source_build
end
