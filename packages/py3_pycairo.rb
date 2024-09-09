require 'buildsystems/pip'

class Py3_pycairo < Pip
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  version '1.27.0-py3.12'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7d48864bc1909f37fde5110f31c67f63a033f0077820e34bed1fd8409f72f45',
     armv7l: 'a7d48864bc1909f37fde5110f31c67f63a033f0077820e34bed1fd8409f72f45',
     x86_64: 'e0ed80053b65186e6c12428ea3fec91838ef9332c7f2b3ce8b68545ab9ba99d3'
  })

  depends_on 'cairo'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'python3' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  no_source_build
end
