require 'buildsystems/pip'

class Py3_pycairo < Pip
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  version "1.29.0-#{CREW_PY_VER}"
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '341c40365f3d5b81677a954024c04c047d266c4b35b5763d22b2741e44b233e6',
     armv7l: '341c40365f3d5b81677a954024c04c047d266c4b35b5763d22b2741e44b233e6',
     x86_64: 'd34a6b061b17238aadb21d6494421e2c55c05dc40a5f9c1e55725ae5af96bc1a'
  })

  depends_on 'cairo'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'python3' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  no_source_build
end
