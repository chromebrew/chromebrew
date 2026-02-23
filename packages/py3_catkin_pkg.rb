require 'buildsystems/pip'

class Py3_catkin_pkg < Pip
  description 'Library for retrieving information about catkin packages.'
  homepage 'https://wiki.ros.org/catkin_pkg'
  version "1.1.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40ebd03764e442634442226b724a70b7314b7ef1bbed7effe6ab8f2f1cca9f54',
     armv7l: '40ebd03764e442634442226b724a70b7314b7ef1bbed7effe6ab8f2f1cca9f54',
       i686: '69df56902a4b8f333576a48cea1606baf63ca436334302bd95ebf6901c12d3f9',
     x86_64: 'ff232f5078497fa29a4c9a849476a55bc79dccf2e1bbd22fa99d16bb1c0b57ca'
  })

  depends_on 'python3' => :build

  no_source_build
end
