require 'buildsystems/meson'

class Py3cairo < Meson
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  version "1.29.0-#{CREW_PY_VER}"
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/pygobject/pycairo.git'
  git_hashtag "v#{version.gsub("-#{CREW_PY_VER}", '')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c4dabe05355a5753cdb449584f81093aad714aae34e5e507759b616bd24ad59',
     armv7l: '0c4dabe05355a5753cdb449584f81093aad714aae34e5e507759b616bd24ad59',
     x86_64: '57ab0997fcf80d0855dba1483cc17a89f33bdc2bab7a02b302caab9a8bc96faf'
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
