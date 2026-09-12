require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.1.3-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c6f0bc4784d1dae3a527f0c07cb6fac989706fe19ab4b69a50c1aade61a3d8e',
     armv7l: '9c6f0bc4784d1dae3a527f0c07cb6fac989706fe19ab4b69a50c1aade61a3d8e',
       i686: '44feecedae5793f17e94813cba44566143db6d13941d0a9a7273692c8c7bdc89',
     x86_64: '0ccbb6ffba4a365fb717546c9cbd7157cc70d6b5281368cf94ea1996e0a1588d'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
