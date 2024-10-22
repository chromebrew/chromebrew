require 'buildsystems/pip'

class Py3_pspdfutils < Pip
  description 'Utilities for manipulating PostScript documents.'
  homepage 'https://github.com/rrthomas/psutils'
  version "3.3.5-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '012e4cb29ee9e67a8b6ffe7fa7b6fc17f4e092279a6608bda6d4a60dddd4e037',
     armv7l: '012e4cb29ee9e67a8b6ffe7fa7b6fc17f4e092279a6608bda6d4a60dddd4e037',
       i686: '95519faebdc8a7dd0117fd4784a54dbc14e69a0e62945f7cd3f0e015890a590a',
     x86_64: 'e5a488f3ef79730103e3bddd36163aa83add084b6595bc3465c365cbd6e89014'
  })

  depends_on 'libpaper'

  no_source_build
end
