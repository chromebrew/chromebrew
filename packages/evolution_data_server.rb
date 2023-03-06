require 'package'

class Evolution_data_server < Package
  description 'Centralized access to appointments and contacts'
  @_ver = '3.46.0'
  version @_ver
  license 'LGPL-2 or LGPL-3, BSD and Sleepycat'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/evolution-data-server.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evolution_data_server/3.46.0_armv7l/evolution_data_server-3.46.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evolution_data_server/3.46.0_armv7l/evolution_data_server-3.46.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evolution_data_server/3.46.0_i686/evolution_data_server-3.46.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evolution_data_server/3.46.0_x86_64/evolution_data_server-3.46.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '856ab38434b324eecacdfdb2981dcbc2e67769680621370e3da09c1d0979d8b4',
     armv7l: '856ab38434b324eecacdfdb2981dcbc2e67769680621370e3da09c1d0979d8b4',
       i686: '303248f7eb4e050cbf846caaf9f23b04c19df4fa624ee90db6c799f891175271',
     x86_64: '57189bbc3c4fa355db5d3e64dc89521f91e7366eadb251b993bd963ec573d1d3'
  })

  depends_on 'at_spi2_core' # R
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
  depends_on 'vulkan_icd_loader' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'webkit2gtk_5' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      cmake #{CREW_CMAKE_LIBSUFFIX_OPTIONS} .. -G Ninja \
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
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
