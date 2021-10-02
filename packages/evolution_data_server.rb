require 'package'

class Evolution_data_server < Package
  description 'Centralized access to appointments and contacts'
  @_ver = '3.40.3'
  version @_ver
  license 'LGPL-2 or LGPL-3, BSD and Sleepycat'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/evolution-data-server.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evolution_data_server/3.40.3_armv7l/evolution_data_server-3.40.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evolution_data_server/3.40.3_armv7l/evolution_data_server-3.40.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/evolution_data_server/3.40.3_x86_64/evolution_data_server-3.40.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8ade9630fc18351495084f5e0ae3ad98fbbcd3e50f937d795d8dc2a1c4c36158',
     armv7l: '8ade9630fc18351495084f5e0ae3ad98fbbcd3e50f937d795d8dc2a1c4c36158',
     x86_64: '9620cad89b0ed797c84b4d7b85b977883678669963c724a679a09c681ef3934f'
  })

  depends_on 'nss'
  depends_on 'gobject_introspection' => :build
  depends_on 'vala' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libsoup'
  depends_on 'gcr'
  depends_on 'libical'
  depends_on 'libsecret'

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
