require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44263a1c9eb3ec571f2b7afdebe75c25f348c6e40758a8eb82afd90043f86064',
     armv7l: '44263a1c9eb3ec571f2b7afdebe75c25f348c6e40758a8eb82afd90043f86064',
       i686: '8655fca66730c39c59f0db30bdbd99ebce4374e96ed070d39b4a91a9bcfd2d37',
     x86_64: 'f183c3a7c7061e1bba8aefce0c9736f8d793868862e35256b597a0da8fb512e2'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
