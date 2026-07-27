require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.8-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5bf99adf22dac86cb332d74eaf48ef522dcba0fb1751e2ab858853bbcebcf6f',
     armv7l: 'c5bf99adf22dac86cb332d74eaf48ef522dcba0fb1751e2ab858853bbcebcf6f',
       i686: '7b7186abd4de4ba11eb0f16cbd1f63c45381374e241fef9372abf251a56b8216',
     x86_64: '3eb9d785296b0ee364182fe60e1db04a103017136991fd50829d9bbb9b9f8f46'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
