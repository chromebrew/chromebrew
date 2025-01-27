require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.25.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85d5ebd584760dd4552719544e3df90ad84c80fa0fd4c8a5031b44a824503036',
     armv7l: '85d5ebd584760dd4552719544e3df90ad84c80fa0fd4c8a5031b44a824503036',
       i686: '92830201eff90bf83ddfe8e6cc1707a460cb921c9539b9f7ef9b6c5e15740f38',
     x86_64: '34212c88debc7862aef953720ddc84072b10b1250cd55354369808ab42c23910'
  })

  depends_on 'python3' => :build

  no_source_build
end
