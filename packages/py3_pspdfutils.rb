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
       i686: '46e94fd6bd4b82a0969a7d03475abbf79fc5a03c7420c26b905c15cf2a13d082',
     x86_64: 'a09fe9189a934923dced94da1823efa39e8da064144dc5b5ba3c9740a0250496'
  })

  depends_on 'libpaper'

  no_source_build
end
