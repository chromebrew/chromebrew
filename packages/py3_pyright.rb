require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.414-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d8848daa4546a73e47592075d3f2c963e57fa8af399e7d59d29633386f48f40',
     armv7l: '1d8848daa4546a73e47592075d3f2c963e57fa8af399e7d59d29633386f48f40',
       i686: '0f24d48d8e92f1f02f11a1da7d4ec90db3261e831af5098dcd9b1a693d816bd9',
     x86_64: '0e922c8ba05f66c68ab1755a34eca6866b285bbbf1176e2293c8565c900b3778'
  })

  depends_on 'py3_nodeenv'
  depends_on 'python3' => :logical

  no_source_build
end
