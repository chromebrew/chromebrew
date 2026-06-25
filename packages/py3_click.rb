require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.4.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a74df8c48b405856dbf5fd36a69cf6e976f3c763c3c4119c13db12ff255e498d',
     armv7l: 'a74df8c48b405856dbf5fd36a69cf6e976f3c763c3c4119c13db12ff255e498d',
       i686: '4ffe375bbe9209235ba34f88dac294958f98ec29f75219f6055d4561140accdb',
     x86_64: '596979b07b075d123f7a05673af2b2c1f4ed89feff2d2ab7c53ec8a20c193540'
  })

  depends_on 'python3' => :logical

  no_source_build
end
