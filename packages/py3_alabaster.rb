require 'buildsystems/pip'

class Py3_alabaster < Pip
  description 'Alabaster is a configurable sidebar-enabled Sphinx theme.'
  homepage 'https://alabaster.readthedocs.io/'
  version '1.0.0-py3.12'
  license 'BSD' # License is BSD-style, might be BSD-3?
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'


  depends_on 'python3' => :build
end
