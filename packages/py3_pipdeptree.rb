require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.24.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26ddb80e2fefc6f481a31a3990649bc136247712e7d5e96b47fb6b1f8b76defa',
     armv7l: '26ddb80e2fefc6f481a31a3990649bc136247712e7d5e96b47fb6b1f8b76defa',
       i686: 'd7ab47aaa1a8ba5b8751ce01d9c582686e55a00743f46a9b3cc05f464adbe6ef',
     x86_64: '2823030080124405e75fcf504bd500dc725b9dd0c7a63f79ef09b75553a3ad07'
  })

  depends_on 'python3' => :build

  no_source_build
end
