require 'buildsystems/pip'

class Py3_catkin_pkg < Pip
  description 'Library for retrieving information about catkin packages.'
  homepage 'https://wiki.ros.org/catkin_pkg'
  version "1.1.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43598fbdde1533b265b09f851b4a9f955f422623c3161ae25987bde4282ef253',
     armv7l: '43598fbdde1533b265b09f851b4a9f955f422623c3161ae25987bde4282ef253',
       i686: 'a08abd48b818fb36310fc16ee55766fa33f76424840f337ac09189fd161c8aa0',
     x86_64: '96b74b3a69adb5a700aced3fd66e83e4b5e904d0af85b78ca55990fa3e8394af'
  })

  depends_on 'python3' => :logical

  no_source_build
end
