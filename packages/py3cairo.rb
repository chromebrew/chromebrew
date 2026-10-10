require 'buildsystems/meson'

class Py3cairo < Meson
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  version "1.29.2-#{CREW_PY_VER}"
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/pygobject/pycairo.git'
  git_hashtag "v#{version.gsub("-#{CREW_PY_VER}", '')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '735078596eb85db2f77e9c66984f83924592f96d4b1103a4dc4da4bc95607f84',
     armv7l: '735078596eb85db2f77e9c66984f83924592f96d4b1103a4dc4da4bc95607f84',
     x86_64: '55fe870f058d3dafba53671e83e1564d829772dbdcb6f88e37cfe38c0c6b3e03'
  })

  depends_on 'cairo' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :build
  depends_on 'libxrender' => :build
  depends_on 'libxxf86vm' => :build
  depends_on 'py3_pycairo' => :logical
  depends_on 'python3' => :logical

  conflicts_ok
end
