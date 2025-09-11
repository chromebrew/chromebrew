require 'buildsystems/pip'

class Py3_readme_renderer < Pip
  description 'Safely render long_description/README files in Warehouse'
  homepage 'https://github.com/pypa/readme_renderer'
  version '44.0'
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ec8e84241b2eba4ac52980afaa1e51b10c399f335f6aa2e61a9198bc9562ea2',
     armv7l: '9ec8e84241b2eba4ac52980afaa1e51b10c399f335f6aa2e61a9198bc9562ea2',
       i686: '8c95141b0d1264417e087df83c56bdcb966d6c85b8682712f1322ed0a8660fca',
     x86_64: 'd9d32c0fd205fb588f4d3eeded8ee3d1cb4d80f0d281bfa433b6d8e083492975'
  })

  depends_on 'py3_bleach' => :build
  depends_on 'py3_docutils' => :build
  depends_on 'py3_nh3' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
