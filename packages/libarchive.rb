require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.0-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 '67bfac3798a778143f4b1cadcdb3792b4269486f8e1b70ca5c0ee5841398bfdf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6dc32b68cde446f9d03c8c3f88f73336cd95fe0a0985ad30e0644004cc80b49',
     armv7l: 'b6dc32b68cde446f9d03c8c3f88f73336cd95fe0a0985ad30e0644004cc80b49',
       i686: '4ea6d55eb8808bad6a55048cf5b056317252422a5a1fa7104c60e7e8d6c65d02',
     x86_64: '4cbf4f789963be08a41acde6fc9f01bb5f6e2307a4513f13d7c48b017251871e'
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

  cmake_options '-DENABLE_TEST=OFF'

  def self.patch
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
end
