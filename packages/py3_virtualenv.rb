require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.10.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e84fe5bb98f53c5dd6a048438a6233ce16e67266a859918d6fce47d243792195',
     armv7l: 'e84fe5bb98f53c5dd6a048438a6233ce16e67266a859918d6fce47d243792195',
       i686: '2779239b854e2258abd290e4416de2289f85dc502b9efc718e29eca4b80f364b',
     x86_64: 'fe7b14e2f455e364e16740e19ff65960140d71dbc2dfae28a036ed05a7cf2463'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
