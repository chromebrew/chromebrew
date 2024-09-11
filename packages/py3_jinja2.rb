require 'buildsystems/pip'

class Py3_jinja2 < Pip
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  version '3.1.4-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10a1af81659a9ee7ff1e1823bc5a33596fa5e557fd3e67b3031cab20a71ea5eb',
     armv7l: '10a1af81659a9ee7ff1e1823bc5a33596fa5e557fd3e67b3031cab20a71ea5eb',
       i686: '75687b5b46f3708a27e3a0c92a88ff5d93726424afbd16b53a47099b3df99eec',
     x86_64: '1fafdd157ad8bbc5e01fea111b27e7673fba05c4ea2bb738aecfc3d06ca2800f'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
