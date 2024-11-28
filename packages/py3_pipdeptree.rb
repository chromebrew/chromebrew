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
    aarch64: '85d5ebd584760dd4552719544e3df90ad84c80fa0fd4c8a5031b44a824503036',
     armv7l: '85d5ebd584760dd4552719544e3df90ad84c80fa0fd4c8a5031b44a824503036',
       i686: 'd7ab47aaa1a8ba5b8751ce01d9c582686e55a00743f46a9b3cc05f464adbe6ef',
     x86_64: '34212c88debc7862aef953720ddc84072b10b1250cd55354369808ab42c23910'
  })

  depends_on 'python3' => :build

  no_source_build
end
