require 'buildsystems/pip'

class Py3_mutagen < Pip
  description 'Python module for handling audio metadata'
  homepage 'https://mutagen.readthedocs.io/'
  @_ver = '1.47.0'
  version "#{@_ver}-py3.12"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' # L

  no_compile_needed
end
