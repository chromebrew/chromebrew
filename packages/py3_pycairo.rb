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
    aarch64: 'dbb506e2a2965ce42a3f6b9d354209619acd57d51aef7331b64fd25996d8b30c',
     armv7l: 'dbb506e2a2965ce42a3f6b9d354209619acd57d51aef7331b64fd25996d8b30c',
     x86_64: 'b4f5f94991486308cb17e911a3d69a9621689d5f90e961d154cbd7a4f43a5dd0'
  })

  depends_on 'cairo' => :library
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' # R
  depends_on 'libxrender'
  depends_on 'libxxf86vm'
  depends_on 'python3' => :logical

  no_source_build
end
