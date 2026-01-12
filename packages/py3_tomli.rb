require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '45145991e82d4babd67373271af813b5a5fa4d3cb2207690fbcddf9cc4fd27b0',
     armv7l: '45145991e82d4babd67373271af813b5a5fa4d3cb2207690fbcddf9cc4fd27b0',
       i686: '17e232ed8240dc87b280783ee93be5d392e4c8d21ae54b66cd2f2684a23fad1c',
     x86_64: '3c601c3847dd6c98824ee56f771e589ba65cfff558d0fdf24d730f715d135213'
  })

  depends_on 'glibc' # R
  depends_on 'py3_flit_core'
  depends_on 'python3'

  no_source_build
end
