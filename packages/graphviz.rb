require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  @_ver = '7.1.0'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://gitlab.com/graphviz/graphviz.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/7.1.0_armv7l/graphviz-7.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/7.1.0_armv7l/graphviz-7.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/7.1.0_i686/graphviz-7.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/7.1.0_x86_64/graphviz-7.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7c8572e45f268f52eea6213b5191687f9289ccdfb5bcae98896435f44e91918a',
     armv7l: '7c8572e45f268f52eea6213b5191687f9289ccdfb5bcae98896435f44e91918a',
       i686: 'da761f75ea9ccfd0372f6c94b1a87172bb8e89cc8ab257f352cb08117e14fb09',
     x86_64: 'a695af69c648392c30af266e8916dee9a4940ec650fd9cca70dc07603f8e1018'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' => :build
  depends_on 'expat' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk2' # R
  depends_on 'harfbuzz' # R
  depends_on 'libgd' # R
  depends_on 'libpng' => :build
  depends_on 'libtool' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxrender' # R
  depends_on 'pango' # R
  depends_on 'qtbase' unless ARCH == 'i686'
  depends_on 'zlibpkg' # R
  depends_on 'ghostscript' # R

  def self.patch
    system "sed -i 's|/usr|#{CREW_PREFIX}|g' cmake/config_checks.cmake"
    # system 'patch -Np1 -i graphviz_cmake.patch'
  end

  def self.build
    # gvedit pulls in the QT dependency.
    @gvedit = ARCH == 'i686' ? 'OFF' : 'ON'
    system "AWK=#{CREW_PREFIX}/bin/mawk \
        cmake -B builddir \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -Dwith_gvedit=#{@gvedit}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    # There is a library error only when installing dot using the following command.
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install || true"
  end

  def self.postinstall
    # Without this, builds of rest fail.
    system 'dot -c'
  end
end
