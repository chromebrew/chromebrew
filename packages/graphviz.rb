require 'buildsystems/cmake'

class Graphviz < CMake
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '9.0.0'
  license 'BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.com/graphviz/graphviz.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/9.0.0_armv7l/graphviz-9.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/9.0.0_armv7l/graphviz-9.0.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/9.0.0_x86_64/graphviz-9.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c12deae6fa8b9d66b083bcd159658b5f693bd93814f1d6d33736c5944336bd2e',
     armv7l: 'c12deae6fa8b9d66b083bcd159658b5f693bd93814f1d6d33736c5944336bd2e',
     x86_64: '87162917d3aeab886e233df4863b76ce830f9d4f5c4ea0f3299210a0be2f40c1'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'ghostscript' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'libgd' # R
  depends_on 'libpng' => :build
  depends_on 'librsvg' # R
  depends_on 'libtool' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxrender' # R
  depends_on 'pango' # R
  depends_on 'qt5_base' # R
  depends_on 'zlibpkg' # R

  def self.install
    # There is a library error only when installing dot using the following command.
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install || true"
  end

  def self.postinstall
    # Without this, builds of rest fail.
    system 'dot -c'
  end
end
