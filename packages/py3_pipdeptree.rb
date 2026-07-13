require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "3.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '437b56a6b39b78272805c760c8414d895dab44b9a001b3d3dab62bada4da82d3',
     armv7l: '437b56a6b39b78272805c760c8414d895dab44b9a001b3d3dab62bada4da82d3',
       i686: '1098471a83331deb59ae83cb22cc93a8d8dbf0f9b2348c3b6c789fa2ef6f050d',
     x86_64: '072ab150f0600d9c0403cafeed0e5a27ca7f55c8edd82c4c3920b1621eb6d696'
  })

  depends_on 'python3' => :logical

  no_source_build
end
