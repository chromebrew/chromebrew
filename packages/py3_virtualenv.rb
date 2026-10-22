require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e2aa3188388a220f08707a156645aa59d3b26af7b1404b927c2b42550218dc5',
     armv7l: '5e2aa3188388a220f08707a156645aa59d3b26af7b1404b927c2b42550218dc5',
       i686: 'b187d5efedf811b0447c2b6e0975c78eab112e8a5b30484540568b422245aed2',
     x86_64: 'a5a5e7df009532822b6f6d1760cfe6a2ac1d538585bf01bb47c70f0e76a887cb'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
