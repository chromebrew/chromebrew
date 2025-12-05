require 'buildsystems/pip'

class Py3_readme_renderer < Pip
  description 'Safely render long_description/README files in Warehouse'
  homepage 'https://github.com/pypa/readme_renderer'
  version "44.0-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ede8109728d102a78d3035293b819f96d5d4c18e9f82047db1c8b77359cfd0b5',
     armv7l: 'ede8109728d102a78d3035293b819f96d5d4c18e9f82047db1c8b77359cfd0b5',
       i686: '460f1a73b0282bb82dd11f4b1f8b04a48ca2cb12685dd4c9dfa1b65dfa73cf9a',
     x86_64: '8bc7195c1c9418a1678a47ca803e965702de64e4f62de72c7b31dc5006e163b2'
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
