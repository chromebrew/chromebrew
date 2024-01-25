require 'buildsystems/pip'

class Sphinx < Pip
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '4.9.1'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ddd6e74e262d728dbd2f14232bc4656f9697a10e97f690671964bfbd3135be1',
     armv7l: '3ddd6e74e262d728dbd2f14232bc4656f9697a10e97f690671964bfbd3135be1',
       i686: '1f27ff0a89d9808f6128770381bf2e4e3d09113c53fb0509d7de40c27fd4d899',
     x86_64: 'd9704da781764f0a74a18a963ad304ca3667abd981e778de646d243e72086277'
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
end
