require 'buildsystems/pip'

class Py3_readme_renderer < Pip
  description 'Safely render long_description/README files in Warehouse'
  homepage 'https://github.com/pypa/readme_renderer'
  version "45.0-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c3d720621478d5ce8d8712d3eb3ff52e806d057cdfed4cec0776b219e4cba6b',
     armv7l: '4c3d720621478d5ce8d8712d3eb3ff52e806d057cdfed4cec0776b219e4cba6b',
       i686: '65f5616ed1b1b20c6705f0b7599717a27afe0ba9d41d611170ec18a360260773',
     x86_64: '7cefda7c6ae524745fb47736a2cc2aa36203c9de290a92d8fe909f4e036cb989'
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
