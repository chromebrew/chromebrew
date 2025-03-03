require 'buildsystems/pip'

class Sphinx < Pip
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation.'
  homepage 'https://www.sphinx-doc.org/'
  version "8.2.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6764f77ebf38bfd24b6b7f04a706f355fd9fa0152bd98b5a52cad2f4e83ce069',
     armv7l: '6764f77ebf38bfd24b6b7f04a706f355fd9fa0152bd98b5a52cad2f4e83ce069',
       i686: '571a39c763c37998cc201762dec07f971cea79452285a6689678cff5fed39a31',
     x86_64: '5e6286de0c9ebe9d30556f3717c690f4997d8676243688d7d6aceb04c491a114'
  })

  depends_on 'py3_jinja2'
  depends_on 'py3_sphinxcontrib_devhelp'
  depends_on 'py3_sphinxcontrib_applehelp'
  depends_on 'py3_sphinxcontrib_jsmath'
  depends_on 'py3_sphinxcontrib_serializinghtml'
  depends_on 'py3_sphinxcontrib_qthelp'
  depends_on 'py3_sphinxcontrib_htmlhelp'
  depends_on 'py3_docutils'
  depends_on 'py3_imagesize'
  depends_on 'py3_requests'
  depends_on 'py3_babel'
  depends_on 'py3_alabaster'
  depends_on 'py3_pygments'
  depends_on 'py3_packaging'
  depends_on 'py3_snowballstemmer'
  depends_on 'python3' => :build

  no_source_build
end
