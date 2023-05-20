require 'package'

class Evolution_data_server < Package
  description 'Centralized access to appointments and contacts'
  @_ver = '3.48.1'
  version @_ver
  license 'LGPL-2 or LGPL-3, BSD and Sleepycat'
  compatibility 'x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/evolution-data-server.git'
  git_hashtag @_ver

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evolution_data_server/3.48.1_x86_64/evolution_data_server-3.48.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '59465eb6457d3f2a01fa24983d0a99226d22145674bd6a5c38244b12569d617f'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'gcc' # R
  depends_on 'gcr_3' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'krb5' # R
  depends_on 'libdb' # R
  depends_on 'libical' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup'
  depends_on 'libsoup2' # R
  depends_on 'libxml2' # R
  depends_on 'nss' # R
  depends_on 'p11kit' # R
  depends_on 'pango' # R
  depends_on 'sqlite' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R
  depends_on 'e2fsprogs' # R
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'json_glib' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'webkitgtk_6' # R

  def self.build
    system "LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      cmake #{CREW_CMAKE_LIBSUFFIX_OPTIONS} -B builddir -G Ninja \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DENABLE_CANBERRA=OFF \
      -DENABLE_EXAMPLES=OFF \
      -DENABLE_GOA=OFF \
      -DENABLE_GOOGLE=OFF \
      -DENABLE_GTK_DOC=OFF \
      -DENABLE_INTROSPECTION=OFF \
      -DENABLE_OAUTH2=OFF \
      -DENABLE_VALA_BINDINGS=OFF \
      -DENABLE_WEATHER=OFF \
      -DWITH_NSPR_INCLUDES=#{CREW_PREFIX}/include/nspr \
      -DWITH_NSS_INCLUDES=#{CREW_PREFIX}/include/nss \
      -DWITH_OPENLDAP=OFF \
      -DWITH_PHONENUMBER=OFF"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
