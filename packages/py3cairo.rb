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
    aarch64: '64de3bc27460ab7585217191523d2f076df9ef5594711dc250c7f884fb7ba556',
     armv7l: '64de3bc27460ab7585217191523d2f076df9ef5594711dc250c7f884fb7ba556',
     x86_64: '130564f02f1d5612ea5662bcf5455cb94d1413e5868f367dee5681e04674c8b5'
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
