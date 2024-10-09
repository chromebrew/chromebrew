require 'buildsystems/pip'

class Sphinx < Pip
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation.'
  homepage 'https://www.sphinx-doc.org/'
  version "8.0.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18d0e900669705e6e9c19427f4d1da90ef884b3f72ebffd7d233411861bcdb4e',
     armv7l: '18d0e900669705e6e9c19427f4d1da90ef884b3f72ebffd7d233411861bcdb4e',
       i686: 'd1224954a2976640dd315215f4b2000b2116ecd96369cc6e45f52d735ca2487d',
     x86_64: '2ebe0e0057c408a248471a61a82f7595e0b5a6e87cd1b81329345e301f57da9f'
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
