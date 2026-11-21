require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.11-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c6aebc9f16a0561cd64c7df03063b8f26e706e4abdd2ea3e73eaa16d4fd56a11',
     armv7l: 'c6aebc9f16a0561cd64c7df03063b8f26e706e4abdd2ea3e73eaa16d4fd56a11',
       i686: 'dc00fa2fcbce3bae6c70b3bb5c51b2715042f37d314231614f9f6ea71f164728',
     x86_64: '7329b8d42018ca2c1e62c1d0bf1103b4eca32c09175211aa6ea36c8ca7900c42'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
