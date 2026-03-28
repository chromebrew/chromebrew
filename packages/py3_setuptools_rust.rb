require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  version "1.12.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b64f300cb41d6b2fe2cd3a8534cb37bd1931c465962cb3bc71bb925dba8aa68',
     armv7l: '6b64f300cb41d6b2fe2cd3a8534cb37bd1931c465962cb3bc71bb925dba8aa68',
       i686: 'df33d179b0b22a78667a6dcb37f4867b4769cd5a5f2212afa295a9dbec1f25be',
     x86_64: '32326de47197af564fc140c4d5a8ccf7856995e95ae32ce08afe06f56beff709'
  })

  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
  depends_on 'python3'
  depends_on 'python3' => :logical
  depends_on 'rust'

  no_source_build
end
