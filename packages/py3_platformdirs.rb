require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.3.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aea0f78d4678ea076fe54ee548fb7d66c6ae51e0b7adf7b7bc44988a5ae12faa',
     armv7l: 'aea0f78d4678ea076fe54ee548fb7d66c6ae51e0b7adf7b7bc44988a5ae12faa',
       i686: 'b444e71569ed92b27620aefa15692667f38be64dc2d4665f53e625b99b91eee6',
     x86_64: 'b5dfda11fc1e0fbb8dc8fbb8337e84eb27f390fda3e7264042138b569dbc64a6'
  })

  depends_on 'python3' => :build

  no_source_build
end
