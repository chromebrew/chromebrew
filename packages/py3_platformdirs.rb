require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.13.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b089ff5282ff9924ccb6cdf7191fbce93781b4bc12682d9e58450b495c240bb',
     armv7l: '7b089ff5282ff9924ccb6cdf7191fbce93781b4bc12682d9e58450b495c240bb',
       i686: '71f84cae0c7541e195b1d3b7a6b5e21342f4e92febaeaddf23313e74847f428f',
     x86_64: '148c30c927bbaf366c0bf9212601f31b68c935872190f59cb79a8606743a5365'
  })

  depends_on 'python3' => :logical

  no_source_build
end
