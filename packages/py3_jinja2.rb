require 'buildsystems/pip'

class Py3_jinja2 < Pip
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  version "3.1.6-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf2854d6c90ae17f56cddd141bee6ebdef5bb6a8ae64a0d5fdfe638b6a61950f',
     armv7l: 'cf2854d6c90ae17f56cddd141bee6ebdef5bb6a8ae64a0d5fdfe638b6a61950f',
       i686: '8e2b1f1565af987f9e8f9e22db94a1d231c4994fd88b4070a3c80db9ee83bafb',
     x86_64: 'b1364a868ef41931acbf89d02d1d30d85f9fa01bee6c4711ed3233ac2ef794e9'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :logical

  no_source_build
end
