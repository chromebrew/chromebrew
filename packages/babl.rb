require 'buildsystems/meson'

class Babl < Meson
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.108'
  license 'LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.108.tar.xz'
  source_sha256 '26defe9deaab7ac4d0e076cab49c2a0d6ebd0df0c31fd209925a5f07edee1475'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '854757b20dd4e195458d9bb5ca1956d19cccb241aaf501da943ad8a01e9ea6ee',
     armv7l: '854757b20dd4e195458d9bb5ca1956d19cccb241aaf501da943ad8a01e9ea6ee',
     x86_64: 'cbb8b50166bebbb007c7db60b7325c15be14f8be2bf41ab7e7d69f5893873b93'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'lcms' # R
  depends_on 'pango' => :build
  depends_on 'vala' => :build

  meson_options '-Denable-gir=true'

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
