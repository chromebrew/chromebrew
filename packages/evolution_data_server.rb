require 'buildsystems/cmake'

class Evolution_data_server < CMake
  description 'Centralized access to appointments and contacts'
  homepage 'https://wiki.gnome.org/Apps/Evolution'
  version "3.59.1-#{CREW_ICU_VER}"
  license 'LGPL-2 or LGPL-3, BSD and Sleepycat'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/evolution-data-server.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02d96c1c716a9bf192841ec6e982c7f37dda2e2ae094aff289b3c30cc76b9af0',
     armv7l: '02d96c1c716a9bf192841ec6e982c7f37dda2e2ae094aff289b3c30cc76b9af0',
     x86_64: '4c127f6489de37551feb79a0236b75bce12d970954ea7b6abe9f9e710903de8a'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'e2fsprogs' # R
  depends_on 'gcc_lib' # R
  depends_on 'gcr_3' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'json_glib' # R
  depends_on 'krb5' # R
  depends_on 'libdb' # R
  depends_on 'libical' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libsoup2' # R
  depends_on 'libxml2' # R
  depends_on 'nss' # R
  depends_on 'p11kit' # R
  depends_on 'pango' # R
  depends_on 'sqlite' # R
  depends_on 'util_linux' # R
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'webkitgtk_6' # R
  depends_on 'zlib' # R

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
    -DLIB_SUFFIX=#{ARCH.eql?('x86_64') ? '64' : ''} \
    -DWITH_NSPR_INCLUDES=#{CREW_PREFIX}/include/nspr \
    -DWITH_NSS_INCLUDES=#{CREW_PREFIX}/include/nss \
    -DWITH_OPENLDAP=OFF \
    -DWITH_PHONENUMBER=OFF"
end
