require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  @_ver = '2.46.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://gitlab.com/graphviz/graphviz/-/archive/#{@_ver}/graphviz-#{@_ver}.tar.bz2"
  source_sha256 'e5d7580b3dfcbeb0b86f28dd3c2df76f32086bb428f67c8ae8512e5fd969324d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.46.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.46.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.46.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.46.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4ae28e2e66dc90f4c0ff235578512a9e972490db1a2e8042fc71b800fd034003',
     armv7l: '4ae28e2e66dc90f4c0ff235578512a9e972490db1a2e8042fc71b800fd034003',
       i686: '2fb2eff8637b036a92334b66986ac0ce9fb1f36aa358d2d72f3169187a8ac0ff',
     x86_64: '3e2ece533cf5bbe49ecb90254c3ad1b2b1fa2274a22eb0c09662701da807a44c'
  })

  depends_on 'libgd'
  depends_on 'pango'

  def self.patch
    # The patch below derives from these steps.
    # system 'cp  CMakeLists.txt CMakeLists.txt.orig'
    # system "sed -i '/include(FeatureSummary)/a include(GNUInstallDirs)'  CMakeLists.txt"
    # system "sed -i 's|set(LIBRARY_INSTALL_DIR     lib)|set(LIBRARY_INSTALL_DIR     \"\${CMAKE_INSTALL_LIBDIR}\")|g' CMakeLists.txt"
    # system "sed -i 's|set(PKGCONFIG_DIR	    lib/pkgconfig)|set(PKGCONFIG_DIR	     \"\${CMAKE_INSTALL_LIBDIR}/pkgconfig\")|g' CMakeLists.txt"
    # system "sed -i 's|\${CMAKE_INSTALL_PREFIX}/lib|\${CMAKE_INSTALL_PREFIX}/\${CMAKE_INSTALL_LIBDIR}|g' CMakeLists.txt"
    # system "sed -i 's|list(APPEND CMAKE_INCLUDE_PATH /usr/lib /usr/local/lib /usr/lib/x86_64-linux-gnu)|list(APPEND CMAKE_INCLUDE_PATH /usr/lib /usr/local/lib /usr/lib/x86_64-linux-gnu \"\${CMAKE_INSTALL_PREFIX}\")|g' CMakeLists.txt"
    # system 'ls -aFl CMakeLists.txt*'
    # system 'diff -Npaur CMakeLists.txt.orig CMakeLists.txt > /output/graphviz.patch || true'
    # system 'cp cmake/configure_plugins.cmake cmake/configure_plugins.cmake.orig'
    # system "sed -i 's|set(ENV{LD_LIBRARY_PATH} \"\${ROOT}/lib\")|set(ENV{LD_LIBRARY_PATH} \"\${ROOT}/\${CMAKE_INSTALL_LIBDIR}\")|g' cmake/configure_plugins.cmake"
    # system 'diff -Npaur cmake/configure_plugins.cmake.orig cmake/configure_plugins.cmake >> /output/graphviz.patch || true'
    system "sed -i 's|/usr|#{CREW_PREFIX}|g' cmake/config_checks.cmake"
    @graphviz_cmake_patch = <<~'CMAKE_PATCH_EOF'
      --- CMakeLists.txt.orig	2021-03-10 16:59:26.690413145 +0000
      +++ CMakeLists.txt	2021-03-10 16:59:26.696413066 +0000
      @@ -2,6 +2,7 @@ cmake_minimum_required (VERSION 3.1 FATA
       project (Graphviz)
       
       include(FeatureSummary)
      +include(GNUInstallDirs)
       
       # =============================== Build options ================================
       option(enable_ltdl     "Support on-demand plugin loading" ON)
      @@ -48,11 +49,11 @@ find_package(Perl REQUIRED)
       
       # ================== Convenient values for CMake configuration =================
       set(BINARY_INSTALL_DIR      bin)
      -set(LIBRARY_INSTALL_DIR     lib)
      +set(LIBRARY_INSTALL_DIR     "${CMAKE_INSTALL_LIBDIR}")
       set(PLUGIN_INSTALL_DIR      ${LIBRARY_INSTALL_DIR}/graphviz)
       set(HEADER_INSTALL_DIR      include/graphviz)
       set(MAN_INSTALL_DIR         share/man/man3)
      -set(PKGCONFIG_DIR	    lib/pkgconfig)
      +set(PKGCONFIG_DIR	     "${CMAKE_INSTALL_LIBDIR}/pkgconfig")
       # TODO: Find a way to check for groff and ps2pdf for manpage pdf generation
       # set(MAN_PDF_INSTALL_DIR share/graphviz/doc/pdf)
       set(TOP_SOURCE_DIR          "${CMAKE_CURRENT_SOURCE_DIR}")
      @@ -77,7 +78,7 @@ if (WIN32)
           list(APPEND CMAKE_PREFIX_PATH ${WINDOWS_DEPENDENCY_DIR})
           list(APPEND CMAKE_PREFIX_PATH ${WINDOWS_DEPENDENCY_VCPKG_DIR})
       else()
      -    list(APPEND CMAKE_INCLUDE_PATH /usr/lib /usr/local/lib /usr/lib/x86_64-linux-gnu)
      +    list(APPEND CMAKE_INCLUDE_PATH /usr/lib /usr/local/lib /usr/lib/x86_64-linux-gnu "${CMAKE_INSTALL_PREFIX}")
       endif()
       
       find_package(ANN)
      @@ -211,7 +212,7 @@ set(GVPLUGIN_VERSION "${GRAPHVIZ_PLUGIN_
       set(VERSION "${GRAPHVIZ_VERSION_STRING}")
       set(prefix "${CMAKE_INSTALL_PREFIX}")
       set(exec_prefix "${CMAKE_INSTALL_PREFIX}")
      -set(libdir "${CMAKE_INSTALL_PREFIX}/lib")
      +set(libdir "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
       set(includedir "${CMAKE_INSTALL_PREFIX}/include")
       set(PACKAGE "graphviz")
       configure_file(${CMAKE_CURRENT_SOURCE_DIR}/lib/cdt/libcdt.pc.in ${CMAKE_CURRENT_SOURCE_DIR}/libcdt.pc @ONLY)
      --- cmake/configure_plugins.cmake.orig	2021-03-10 16:59:26.699413027 +0000
      +++ cmake/configure_plugins.cmake	2021-03-10 16:59:26.700413013 +0000
      @@ -30,7 +30,7 @@ set(ROOT $ENV{DESTDIR}${CMAKE_INSTALL_PR
       if (APPLE)
         set(ENV{DYLD_LIBRARY_PATH} "${ROOT}/lib")
       elseif (UNIX)
      -  set(ENV{LD_LIBRARY_PATH} "${ROOT}/lib")
      +  set(ENV{LD_LIBRARY_PATH} "${ROOT}/${CMAKE_INSTALL_LIBDIR}")
       endif()
       
       execute_process(
    CMAKE_PATCH_EOF
    IO.write('graphviz_cmake.patch', @graphviz_cmake_patch)
    system 'patch -p0 -i graphviz_cmake.patch'
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      # system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -I#{CREW_PREFIX}/include/harfbuzz' \
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      AWK=#{CREW_PREFIX}/bin/mawk \
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
end
