require 'buildsystems/pip'

class Py3_pspdfutils < Pip
  description 'Utilities for manipulating PostScript documents.'
  homepage 'https://github.com/rrthomas/psutils'
  version "3.3.2-py3.12"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'libpaper'

  no_compile_needed
end
