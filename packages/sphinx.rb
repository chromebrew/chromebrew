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
    aarch64: 'f883d18e5ac1e2c8912d2e7ccde0468c7a7bf9e3b599475ac0266f2b8b2f225e',
     armv7l: 'f883d18e5ac1e2c8912d2e7ccde0468c7a7bf9e3b599475ac0266f2b8b2f225e',
       i686: '060fd17d295f208b409eb53507ce7e7d4e43c95afe1528eb18270df740a9c1cc',
     x86_64: '3cd6511ef3ccec94471e32fb3abec177502cafc7914cc504d92140e1d09b9dc6'
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
