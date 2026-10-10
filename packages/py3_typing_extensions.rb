require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.16.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b49ffe5ebbbf9a8852291cb27826861902122dd1daff5e07121cc1ccd7f0903',
     armv7l: '3b49ffe5ebbbf9a8852291cb27826861902122dd1daff5e07121cc1ccd7f0903',
       i686: '59670c2f5f1c5accd271249402a60ac3b9db62a095a4c81bb16db078326c40d0',
     x86_64: '4cb22fcc00c975437867169ddbb150e8d20e1d1fc852779cd2c18a55adb47a74'
  })

  depends_on 'python3' => :logical

  no_source_build
end
