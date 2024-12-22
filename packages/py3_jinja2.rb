require 'buildsystems/pip'

class Py3_jinja2 < Pip
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  version "3.1.5-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b44b4e811e5d08f31c43e9c1ee5a4128c92cab672eef8ca6eaa2d55c2ee2b4f7',
     armv7l: 'b44b4e811e5d08f31c43e9c1ee5a4128c92cab672eef8ca6eaa2d55c2ee2b4f7',
       i686: 'ef74798133039e7836dec1e39655492c234b903d92d6733c0af0e61bb5315836',
     x86_64: '5b8b72c36fad94030d8c44130d5f8bbfb8a6f7aeca845ed759071f8fb7e7c7b5'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
