require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.21.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a944ba559b296925e14cc2648a9fefd6ad0fcf4e020fc0391614aa17a78ad3f2',
     armv7l: 'a944ba559b296925e14cc2648a9fefd6ad0fcf4e020fc0391614aa17a78ad3f2',
       i686: '6215e61e608711a4727016c29b53041e8167a2e1459c64f99346b3fea9f86a33',
     x86_64: '9dca8e22714688141846c2d1a93d6096138927d21d3907a9600587b478fdfbf3'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
