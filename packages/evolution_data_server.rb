require 'buildsystems/cmake'

class Evolution_data_server < CMake
  description 'Centralized access to appointments and contacts'
  homepage 'https://wiki.gnome.org/Apps/Evolution'
  version "3.60.1-#{CREW_ICU_VER}"
  license 'LGPL-2 or LGPL-3, BSD and Sleepycat'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/evolution-data-server.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a750e63e71089e5f909bfcebe32c5b9bed7809cfd4327689618927298b3cfbbd',
     armv7l: 'a750e63e71089e5f909bfcebe32c5b9bed7809cfd4327689618927298b3cfbbd',
     x86_64: '8284125ec28b9bc4452db33f625558a75cd6869adc0134f2f914d568d30b0ede'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'e2fsprogs' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gcr_3' # R
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glib_stub' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'graphene' => :library
  depends_on 'gtk3' => :library
  depends_on 'gtk4' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' => :library
  depends_on 'icu4c' => :library
  depends_on 'json_glib' => :library
  depends_on 'krb5' => :library
  depends_on 'libdb' => :library
  depends_on 'libical' => :library
  depends_on 'libsecret' => :library
  depends_on 'libsoup' => :library
  depends_on 'libsoup2' # R
  depends_on 'libxml2' => :library
  depends_on 'libxml2_autotools' => :library
  depends_on 'nss' => :library
  depends_on 'p11kit' # R
  depends_on 'pango' => :library
  depends_on 'sqlite' => :library
  depends_on 'util_linux' => :library
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :library
  depends_on 'webkit2gtk_4_1' => :library
  depends_on 'webkitgtk_6' => :library
  depends_on 'zlib' => :library

  gnome

  cmake_options "-DCMAKE_VERBOSE_MAKEFILE=ON \
    -DENABLE_CANBERRA=OFF \
    -DENABLE_EXAMPLES=OFF \
    -DENABLE_GOA=OFF \
    -DENABLE_GOOGLE=OFF \
    -DENABLE_GTK_DOC=OFF \
    -DENABLE_OAUTH2=OFF \
    -DENABLE_VALA_BINDINGS=OFF \
    -DENABLE_WEATHER=OFF \
    -DLIB_SUFFIX=#{'64' if ARCH.eql?('x86_64')} \
    -DWITH_NSPR_INCLUDES=#{CREW_PREFIX}/include/nspr \
    -DWITH_NSS_INCLUDES=#{CREW_PREFIX}/include/nss \
    -DWITH_OPENLDAP=OFF \
    -DWITH_PHONENUMBER=OFF"
end
