require 'buildsystems/pip'

class Sphinx < Pip
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation.'
  homepage 'https://www.sphinx-doc.org/'
  version "8.1.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ffda35faf2c0f673e924249e24020d9f16f43b3a14f311c6f3cb405c3b5a8eca',
     armv7l: 'ffda35faf2c0f673e924249e24020d9f16f43b3a14f311c6f3cb405c3b5a8eca',
       i686: 'ad0c52b5f828c085976ba15dfed53e5b32ba2b6476ef74e0ef472e65b6664ebb',
     x86_64: '587b358149371b4d5047ae7136a52d06835ee978358aa991d9880fc255353031'
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
