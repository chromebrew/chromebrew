require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.2.5-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ecf20f9ead90db979a7295547db91927ab6d8e3c13955c346b8723894673dd6',
     armv7l: '2ecf20f9ead90db979a7295547db91927ab6d8e3c13955c346b8723894673dd6',
       i686: 'd9b69ba464b6dd727232d6972bda22bdf2fd5cd81799d81575fcb48feae5ee51',
     x86_64: '492fe8fce746d86a414132acb82f081620a3a58b34217fd57d300438779bcf74'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
