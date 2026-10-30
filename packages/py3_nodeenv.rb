require 'buildsystems/pip'

class Py3_nodeenv < Pip
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  version "1.11.1-#{CREW_PY_VER}"
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '28f97992ba3cb45bf78a662385c249b8409fe6955f2e955e293e5bd92d359d85',
     armv7l: '28f97992ba3cb45bf78a662385c249b8409fe6955f2e955e293e5bd92d359d85',
       i686: '1b036485682d7e5f2b36df698de8b222b0b4996478ddb1f8b72d1f28463260c8',
     x86_64: '96a1c3a8931ebeb47ab74969eaa56173f03c125da82b46029c19361da1f9752a'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
