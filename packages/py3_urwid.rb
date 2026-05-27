require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6afc52b6b87ade9644e95643b5eae0d90de98f83a451851005370fdee674aaa5',
     armv7l: '6afc52b6b87ade9644e95643b5eae0d90de98f83a451851005370fdee674aaa5',
       i686: '701fedbb9822c116583dcd648289848e72e13aa0130a35b67bac58e5c6a04ddf',
     x86_64: '2e67f27c849e8650f4136e3b64735b3e631bf4d0f77f3f256c15ab112ec79765'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
