require 'buildsystems/pip'

class Sphinx < Pip
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '4.9.1'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sphinx/4.9.1-py3.12_armv7l/sphinx-4.9.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sphinx/4.9.1-py3.12_armv7l/sphinx-4.9.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sphinx/4.9.1-py3.12_i686/sphinx-4.9.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sphinx/4.9.1-py3.12_x86_64/sphinx-4.9.1-py3.12-chromeos-x86_64.tar.zst'
  })
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
