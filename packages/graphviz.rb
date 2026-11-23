require 'buildsystems/cmake'

class Graphviz < CMake
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '16.1.2'
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
    aarch64: 'fbbaafde64f536c9dd998a60cc3c7aea33b9e3f1d71804daecf1ad960f5eae0a',
     armv7l: 'fbbaafde64f536c9dd998a60cc3c7aea33b9e3f1d71804daecf1ad960f5eae0a',
       i686: 'c5af4a72817c2e1e8f25e6833bea859ff01c6bf5dd519974b35d2f864588f971',
     x86_64: '9ef021eabc7517dc51a8ed30b0301f3c5762340c76481926e6ec66b09b9b9ca4'
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
