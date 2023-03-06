require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  @_ver = '7.0.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://gitlab.com/graphviz/graphviz.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/7.0.2_armv7l/graphviz-7.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/7.0.2_armv7l/graphviz-7.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/7.0.2_i686/graphviz-7.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphviz/7.0.2_x86_64/graphviz-7.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3b9901385fa06dc66d81a21674a8059f0f033d6a1b1fce3a246e9b182d1a1cfd',
     armv7l: '3b9901385fa06dc66d81a21674a8059f0f033d6a1b1fce3a246e9b182d1a1cfd',
       i686: 'd3f57884c68a7d4766e886c7ad70138b3cef6f91980c7d275a8c6c7f6e0956a9',
     x86_64: 'ce900808e60f7fcc5a558a6fe50d8700ccf5f25528a11227d52750ec72621f31'
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
  depends_on 'qtbase' # R
  depends_on 'zlibpkg' # R

  def self.patch
    system "sed -i 's|/usr|#{CREW_PREFIX}|g' cmake/config_checks.cmake"
    @graphviz_cmake_patch = <<~'CMAKE_PATCH_EOF'
      diff -Npaur a/cmake/configure_plugins.cmake.in b/cmake/configure_plugins.cmake.in
      --- a/cmake/configure_plugins.cmake.in	2022-11-19 23:41:08.008581039 -0500
      +++ b/cmake/configure_plugins.cmake.in	2022-11-19 23:59:33.747877029 -0500
      @@ -29,11 +29,11 @@

       set(ROOT $ENV{DESTDIR}${CMAKE_INSTALL_PREFIX})

      -if(APPLE)
      -  set(ENV{DYLD_LIBRARY_PATH} "${ROOT}/@LIBRARY_INSTALL_DIR@")
      -elseif(UNIX)
      -  set(ENV{LD_LIBRARY_PATH} "${ROOT}/@LIBRARY_INSTALL_DIR@")
      -endif()
      +#if(APPLE)
      +#  set(ENV{DYLD_LIBRARY_PATH} "${ROOT}/@LIBRARY_INSTALL_DIR@")
      +#elseif(UNIX)
      +#  set(ENV{LD_LIBRARY_PATH} "${ROOT}/@LIBRARY_INSTALL_DIR@")
      +#endif()

       execute_process(
         COMMAND ${ROOT}/bin/dot -c
    CMAKE_PATCH_EOF
    File.write('graphviz_cmake.patch', @graphviz_cmake_patch)
    system 'patch -Np1 -i graphviz_cmake.patch'
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "AWK=#{CREW_PREFIX}/bin/mawk \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    # Without this, builds of rest fail.
    system 'dot -c'
  end
end
