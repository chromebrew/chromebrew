require 'buildsystems/pip'

class Py3_pspdfutils < Pip
  description 'Utilities for manipulating PostScript documents.'
  homepage 'https://github.com/rrthomas/psutils'
  version "3.3.7-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb7b45f10533aaa293b537c4e8abb64e7ef5c2c21fdb00d9da405558ea70a7c8',
     armv7l: 'fb7b45f10533aaa293b537c4e8abb64e7ef5c2c21fdb00d9da405558ea70a7c8',
       i686: '4cb75f193952659b1ed49a762474e4cddf6db6d23bd4a190171342f1606e652e',
     x86_64: 'a5534106ab2d599cb1f06b9a8b35e53dc59591bf18338748f6f827b37af044b9'
  })

  depends_on 'libpaper'

  no_source_build
end
