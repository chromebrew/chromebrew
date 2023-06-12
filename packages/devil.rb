require 'package'

class Devil < Package
  description 'Library for reading several different image formats'
  homepage 'http://openil.sourceforge.net/'
  version '1.8.0-6f3d5e9'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/DentonW/DevIL.git'
  git_hashtag '6f3d5e9bc5d173f56060fc8e14bed35c8edcfdcc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/devil/1.8.0-6f3d5e9_armv7l/devil-1.8.0-6f3d5e9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/devil/1.8.0-6f3d5e9_armv7l/devil-1.8.0-6f3d5e9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/devil/1.8.0-6f3d5e9_i686/devil-1.8.0-6f3d5e9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/devil/1.8.0-6f3d5e9_x86_64/devil-1.8.0-6f3d5e9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd14bd70a075ad1602a3850451a91c15f91346f5af5fd99bf4f0054c24595498a',
     armv7l: 'd14bd70a075ad1602a3850451a91c15f91346f5af5fd99bf4f0054c24595498a',
       i686: '893a086ba8c9d0bb286bc1ee024f30e8b3dd851dd64053ab2aba744d6585f51e',
     x86_64: '494336d49fee91201c74574356a2bf5c1e5bdc6e5d15bcc03decb99210286664'
  })

  depends_on 'freeglut'
  # arm does not build against current release of jasper
  depends_on 'jasper'
  depends_on 'lcms'
  depends_on 'libglu'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libxi'
  depends_on 'libxmu'
  depends_on 'mesa'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R
  depends_on 'libglvnd' # R

  def self.patch
    system "find -type f -exec sed -i 's,DESTINATION lib,DESTINATION lib#{CREW_LIB_SUFFIX},g' {} +"
    # As per https://github.com/DentonW/DevIL/pull/102
    @jasper_patch = <<~'JASPER_PATCH'
      diff -NPaur a/DevIL/CMakeLists.txt b/DevIL/CMakeLists.txt
      --- a/DevIL/CMakeLists.txt	2022-10-04 19:42:15.952513098 -0400
      +++ b/DevIL/CMakeLists.txt	2022-10-04 19:51:20.745032984 -0400
      @@ -1,4 +1,7 @@
       cmake_minimum_required(VERSION 2.6)
      +set(CMAKE_CXX_STANDARD 11)
      +set(CMAKE_CXX_STANDARD_REQUIRED ON)
      +set(CMAKE_CXX_EXTENSIONS OFF)

       project(ImageLib)
       # include our custom modules
      diff -NPaur a/DevIL/src-IL/src/il_jp2.cpp b/DevIL/src-IL/src/il_jp2.cpp
      --- a/DevIL/src-IL/src/il_jp2.cpp	2022-10-04 20:11:47.101076834 -0400
      +++ b/DevIL/src-IL/src/il_jp2.cpp	2022-10-04 20:13:42.238279652 -0400
      @@ -324,22 +324,30 @@
       // see: https://github.com/OSGeo/gdal/commit/9ef8e16e27c5fc4c491debe50bf2b7f3e94ed334
       //      https://github.com/DentonW/DevIL/issues/90
       #if defined(PRIjas_seqent)
      +#if JAS_VERSION_MAJOR >= 3
      +static long int iJp2_file_read(jas_stream_obj_t *obj, char *buf, long unsigned int cnt)
      +#elif JAS_VERSION_MAJOR < 3
       static int iJp2_file_read(jas_stream_obj_t *obj, char *buf, unsigned cnt)
       #else
       static int iJp2_file_read(jas_stream_obj_t *obj, char *buf, int cnt)
       #endif
      +#endif
       {
       	obj;
       	return iread(buf, 1, cnt);
       }

       #if defined(JAS_INCLUDE_JP2_CODEC)
      +#if JAS_VERSION_MAJOR >= 3
      +static long int iJp2_file_write(jas_stream_obj_t *obj, const char *buf, long unsigned int cnt)
      +#elif JAS_VERSION_MAJOR < 3
       static int iJp2_file_write(jas_stream_obj_t *obj, const char *buf, unsigned cnt)
       #elif defined(PRIjas_seqent)
       static int iJp2_file_write(jas_stream_obj_t *obj, char *buf, unsigned cnt)
       #else
       static int iJp2_file_write(jas_stream_obj_t *obj, char *buf, int cnt)
       #endif
      +#endif
       {
       	obj;
       	return iwrite(buf, 1, cnt);
    JASPER_PATCH
    File.write('jasper.patch', @jasper_patch)
    system 'patch -Np1 -i jasper.patch' if ARCH == 'x86_64'
  end

  def self.build
    Dir.mkdir 'DevIL/builddir'
    Dir.chdir 'DevIL/builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS.sub(/--build=.*/, '')} \
        -DBUILD_SHARED_LIBS=ON \
        .."
    end
    system 'ninja -C DevIL/builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C DevIL/builddir install"
  end
end
