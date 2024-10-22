require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "3.20.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6256110cdfec415e016f6ada5b82124d21d534441eb3880080131e10a63b703b',
     armv7l: '6256110cdfec415e016f6ada5b82124d21d534441eb3880080131e10a63b703b',
       i686: 'ddf53236d4d8faf715cf8d43b7e731681d8c51b0ff437c78bc7e23e66b077a0e',
     x86_64: '9eb4eba0306a25b20e40e326394c3b53991eeb7fc004c1a788f44bd1dff1567a'
  })

  depends_on 'python3' => :build

  no_source_build
end
