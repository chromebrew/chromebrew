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
    aarch64: '47b12c73255b67630fab3b0d53ff592649b28c3951659aad5a70ca7ef7b02b0b',
     armv7l: '47b12c73255b67630fab3b0d53ff592649b28c3951659aad5a70ca7ef7b02b0b',
     x86_64: '6ab5681782aec8f58d22b2bbed6a842227e6b3e1267cfe4981c57639ed335287'
  })

  depends_on 'cairo'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'python3' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  no_source_build
end
