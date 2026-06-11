require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.20.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d73f4146cc788b890b60134af2c4d78fcd5dbe942a9ee1cfbcebbfccce47dfc',
     armv7l: '8d73f4146cc788b890b60134af2c4d78fcd5dbe942a9ee1cfbcebbfccce47dfc',
       i686: '7bae4eb4d76299cbae80266ea0d21493b5e4713c2d19b39193e5d18fd2a3a091',
     x86_64: '755efb13244ef8926dcc2b4c56d8189ac8d4164a4cfa61e8a4bb7e45c01c5476'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
