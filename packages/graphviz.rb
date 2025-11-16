require 'buildsystems/cmake'

class Graphviz < CMake
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '14.0.4'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/graphviz/graphviz.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a4836d2f75970e3cf7fd7817df058f6f248d1de5db4e0f25c840811b8833885',
     armv7l: '5a4836d2f75970e3cf7fd7817df058f6f248d1de5db4e0f25c840811b8833885',
     x86_64: '503c217ee76c05a0abb1d3da94b265e0143c8575ac4ad81962bd0cca7349d3eb'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'ghostscript' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
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
  depends_on 'zlib' # R

  def self.install
    # There is a library error only when installing dot using the following command.
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install || true"
  end

  def self.postinstall
    # Without this, builds of rest fail.
    system 'dot -c'
  end
end
