require 'buildsystems/autotools'

class Exo < Autotools
  description 'Extension library for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '4.20.0'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/exo/#{version.rpartition('.')[0]}/exo-#{version}.tar.bz2"
  source_sha256 '4277f799245f1efde01cd917fd538ba6b12cf91c9f8a73fe2035fd5456ec078d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29c6db515960f02636859f30c0cd983d90bae54239be751edad658eae5eb56cf',
     armv7l: '29c6db515960f02636859f30c0cd983d90bae54239be751edad658eae5eb56cf',
     x86_64: '2c61c320e8c783cabdd17ea803e1d0e6e4317df5a03120073fd717eaf04c7b59'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libxfce4ui' # R
  depends_on 'libxfce4util' # R
  depends_on 'pango' # R
  depends_on 'valgrind' => :build
  depends_on 'xfce4_dev_tools' # R
  depends_on 'zlib' # R

  def self.prebuild
    ConvenienceFunctions.libtoolize('glib-2.0', 'glib')
  end

  run_tests
end
