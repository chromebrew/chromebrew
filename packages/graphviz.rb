require 'buildsystems/cmake'

class Graphviz < CMake
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '15.0.0'
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
    aarch64: '6f29684ec1fb06f29841474639eb8a7a1c332aec301c4b711b117c0a30dee462',
     armv7l: '6f29684ec1fb06f29841474639eb8a7a1c332aec301c4b711b117c0a30dee462',
       i686: 'f123bf670b148726c59627b760f991d6109f0f9f0e016f58fa1d7dd657028573',
     x86_64: 'cc7319d9111f4b1efae8c43eb8c23f4607f67b181f2e92949e8b8c71c76efc32'
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
