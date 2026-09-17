require 'buildsystems/cmake'

class Graphviz < CMake
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '16.1.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://gitlab.com/graphviz/graphviz.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a4836d2f75970e3cf7fd7817df058f6f248d1de5db4e0f25c840811b8833885',
     armv7l: '5a4836d2f75970e3cf7fd7817df058f6f248d1de5db4e0f25c840811b8833885',
     x86_64: '503c217ee76c05a0abb1d3da94b265e0143c8575ac4ad81962bd0cca7349d3eb'
  })

  binary_sha256({
    aarch64: '62ba031c2132ac5e5722d134107543b0bae1822be86920a0fec2bf596613d6a3',
     armv7l: '62ba031c2132ac5e5722d134107543b0bae1822be86920a0fec2bf596613d6a3',
       i686: '71ee20c907497e226cda16d8d181c519df81177766f15e3393428d8badf8ae67',
     x86_64: 'ee004f620f3409f061653f3c3fea3a3183b366dbaa19297e93b38c0cc1b0f427'
  })

  unless ARCH.include?('i686')
    depends_on 'cairo' => :library
    depends_on 'gdk_pixbuf' => :library
    depends_on 'ghostscript' => :library
    depends_on 'gtk3' => :library
    depends_on 'harfbuzz' => :library
    depends_on 'librsvg' => :library
    depends_on 'libwebp' => :library
    depends_on 'libx11' => :library
    depends_on 'libxrender' => :library
    depends_on 'pango' => :library
    depends_on 'qt5_base' => :executable
  end
  depends_on 'expat' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libgd' => :library
  depends_on 'libpng' => :build
  depends_on 'libtool' => :library
  depends_on 'zlib' => :library

  cmake_options '-DWITH_GTK=OFF' if ARCH.include?('i686')

  def self.install
    # There is a library error only when installing dot using the following command.
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install || true"
  end

  def self.postinstall
    # Without this, builds of rest fail.
    system 'dot -c'
  end
end
