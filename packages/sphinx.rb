require 'buildsystems/pip'

class Sphinx < Pip
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation.'
  homepage 'https://www.sphinx-doc.org/'
  version "9.2.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4af635d39e5204ea1f50a7c9835e8636ad0f6761a84931cdd5b9d7acf7540478',
     armv7l: '4af635d39e5204ea1f50a7c9835e8636ad0f6761a84931cdd5b9d7acf7540478',
       i686: '5d2c0a4914d0efd89a1949d54a47983e28ab3dcd628852c3529a814c98a35224',
     x86_64: '84ee3a468ddf8ca613d92f0942ed4caec05360beb674d54ea9b8c3e7aae9dc08'
  })

  depends_on 'py3_alabaster' # R
  depends_on 'py3_babel' # R
  depends_on 'py3_docutils' # R
  depends_on 'py3_imagesize' # R
  depends_on 'py3_jinja2' # R
  depends_on 'py3_packaging' # R
  depends_on 'py3_pygments' # R
  depends_on 'py3_requests' # R
  depends_on 'py3_roman_numerals' # R
  depends_on 'py3_snowballstemmer' # R
  depends_on 'py3_sphinxcontrib_applehelp' # R
  depends_on 'py3_sphinxcontrib_devhelp' # R
  depends_on 'py3_sphinxcontrib_htmlhelp' # R
  depends_on 'py3_sphinxcontrib_jsmath' # R
  depends_on 'py3_sphinxcontrib_qthelp' # R
  depends_on 'py3_sphinxcontrib_serializinghtml' # R
  depends_on 'python3' => :logical

  no_source_build
end
