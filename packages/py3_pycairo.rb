require 'buildsystems/python'

class Py3_pycairo < Python
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  version '1.27.0-py3.12'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/pygobject/pycairo.git'
  version '1.27.0-py3.12'
  binary_compression 'tar.zst'

  depends_on 'cairo'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'python3' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
end
