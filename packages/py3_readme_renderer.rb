require 'buildsystems/pip'

class Py3_readme_renderer < Pip
  description 'Safely render long_description/README files in Warehouse'
  homepage 'https://github.com/pypa/readme_renderer'
  version "46.0-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5191be6efd1a28ba4bc4bb6a6ec609243e9b0e2b36c29a64beec9516f01201b',
     armv7l: 'd5191be6efd1a28ba4bc4bb6a6ec609243e9b0e2b36c29a64beec9516f01201b',
       i686: '265f4f55d7a9b6e9cc5811cd99d6af5f77b179422f15cbe546da1c9224177c9b',
     x86_64: '80496afc7688f721f3dae2505cec43a122bd30aea64619ab09add37e2491e273'
  })

  depends_on 'py3_bleach' => :build
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'py3_docutils' => :build
  depends_on 'py3_nh3' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'py3_six' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
