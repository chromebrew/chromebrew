require 'buildsystems/pip'

class Sphinx < Pip
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation.'
  homepage 'https://www.sphinx-doc.org/'
  version "9.1.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b713724e8a7589de9470f8051d7947fe0f2a36003eb388d1f886268ad5f08ccb',
     armv7l: 'b713724e8a7589de9470f8051d7947fe0f2a36003eb388d1f886268ad5f08ccb',
       i686: '85771e05e3a7f9ee81056cd62930234f5db354e68146a8fc2b48a96113501bc1',
     x86_64: '4f71ae6cfb24281a41bfca1a5ba866e9b04a244bebf04f9c1e9ba5788f105c11'
  })

  depends_on 'py3_jinja2' # R
  depends_on 'py3_roman_numerals' # R
  depends_on 'py3_sphinxcontrib_devhelp' # R
  depends_on 'py3_sphinxcontrib_applehelp' # R
  depends_on 'py3_sphinxcontrib_jsmath' # R
  depends_on 'py3_sphinxcontrib_serializinghtml' # R
  depends_on 'py3_sphinxcontrib_qthelp' # R
  depends_on 'py3_sphinxcontrib_htmlhelp' # R
  depends_on 'py3_docutils' # R
  depends_on 'py3_imagesize' # R
  depends_on 'py3_requests' # R
  depends_on 'py3_babel' # R
  depends_on 'py3_alabaster' # R
  depends_on 'py3_pygments' # R
  depends_on 'py3_packaging' # R
  depends_on 'py3_snowballstemmer' # R
  depends_on 'python3' => :build

  no_source_build
end
