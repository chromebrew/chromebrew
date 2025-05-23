require 'buildsystems/autotools'

class Libarchive < Autotools
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.0-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  # source_url "https://github.com/libarchive/libarchive/releases/download/v#{version.split('-').first}/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 '67bfac3798a778143f4b1cadcdb3792b4269486f8e1b70ca5c0ee5841398bfdf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7207f0c8d0bb8f1a2fa547a80cb6f9a4979850926dfb668b70015f423b913a0',
     armv7l: 'c7207f0c8d0bb8f1a2fa547a80cb6f9a4979850926dfb668b70015f423b913a0',
       i686: '67f2fc8f8d75b5182f7bc11c7ffc1d77103963e97aecdf96e94e4f98773ede2d',
     x86_64: '355b85ca8f374aa670ed824c1e7bd196afceac5766ff3eb7b3cdd1d9fdb7f06f'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'bzip2' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  def self.patch
    # Fix complaints about aclocal being too new.
    system 'autoreconf -fiv'
    # Fix LIBDIR being set improperly for cmake.
    # See https://github.com/libarchive/libarchive/pull/2509
    File.write 'libdir.patch', <<~LIBDIR_PATCH_EOF
      diff --git a/build/cmake/CreatePkgConfigFile.cmake b/build/cmake/CreatePkgConfigFile.cmake
      index bc5a43f72a..50caa5e850 100644
      --- a/build/cmake/CreatePkgConfigFile.cmake
      +++ b/build/cmake/CreatePkgConfigFile.cmake
      @@ -29,5 +29,5 @@ CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/build/pkgconfig/libarchive.pc.in
       # And install it, of course ;).
       IF(ENABLE_INSTALL)
         INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/build/pkgconfig/libarchive.pc
      -          DESTINATION "lib/pkgconfig")
      +          DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig")
       ENDIF()
      diff --git a/libarchive/CMakeLists.txt b/libarchive/CMakeLists.txt
      index dd0b2808d9..86997a12ad 100644
      --- a/libarchive/CMakeLists.txt
      +++ b/libarchive/CMakeLists.txt
      @@ -247,7 +247,7 @@ IF(BUILD_SHARED_LIBS)
         ADD_LIBRARY(archive SHARED ${libarchive_SOURCES} ${include_HEADERS})
         TARGET_INCLUDE_DIRECTORIES(archive PUBLIC .)
         TARGET_LINK_LIBRARIES(archive ${ADDITIONAL_LIBS})
      -  SET_TARGET_PROPERTIES(archive PROPERTIES#{' '}
      +  SET_TARGET_PROPERTIES(archive PROPERTIES
                               VERSION ${SOVERSION_FULL}
                               SOVERSION ${SOVERSION}
                               MACHO_COMPATIBILITY_VERSION ${MACHO_COMPATIBILITY_VERSION}
      @@ -265,18 +265,22 @@ IF(NOT WIN32 OR CYGWIN OR NOT BUILD_SHARED_LIBS)
         SET_TARGET_PROPERTIES(archive_static PROPERTIES OUTPUT_NAME archive)
       ENDIF(NOT WIN32 OR CYGWIN OR NOT BUILD_SHARED_LIBS)

      +if(NOT DEFINED CMAKE_INSTALL_LIBDIR)
      +    set(CMAKE_INSTALL_LIBDIR "#{ARCH_LIB}")
      +endif()
      +
       IF(ENABLE_INSTALL)
         # How to install the libraries
         IF(BUILD_SHARED_LIBS)
           INSTALL(TARGETS archive
                   RUNTIME DESTINATION bin
      -            LIBRARY DESTINATION lib
      -            ARCHIVE DESTINATION lib)
      +            LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
      +            ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
         ENDIF(BUILD_SHARED_LIBS)
         INSTALL(TARGETS archive_static
                 RUNTIME DESTINATION bin
      -          LIBRARY DESTINATION lib
      -          ARCHIVE DESTINATION lib)
      +          LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
      +          ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
         INSTALL_MAN(${libarchive_MANS})
         INSTALL(FILES ${include_HEADERS} DESTINATION include)
       ENDIF()
    LIBDIR_PATCH_EOF
    system 'patch -Np1 -i libdir.patch'
  end

  autotools_install_extras do
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
