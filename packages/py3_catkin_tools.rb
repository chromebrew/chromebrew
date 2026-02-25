require 'buildsystems/pip'

class Py3_catkin_tools < Pip
  description 'Provides command line tools for working with catkin.'
  homepage 'https://catkin-tools.readthedocs.org/'
  version "0.9.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd817314bb1e0c3878a192702c709a14a85523d316e99b655d5ea5955036487d9',
     armv7l: 'd817314bb1e0c3878a192702c709a14a85523d316e99b655d5ea5955036487d9',
       i686: '4a9e473eb58639733947c87a1bd3070e45e814b3af11158d416677a46ccb1855',
     x86_64: 'b63a0e417264a860e700afd196ac25224bfd615ac0c2bb3c5969bbbdfa67dff5'
  })

  depends_on 'py3_catkin_pkg'
  depends_on 'py3_nh3'
  depends_on 'py3_osrf_pycommon'
  depends_on 'python3' => :build

  no_source_build
end
