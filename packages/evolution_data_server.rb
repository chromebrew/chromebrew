require 'package'

class Evolution_data_server < Package
  description 'Centralized access to appointments and contacts'
  @_ver = '3.39.2'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/evolution-data-server/archive/#{@_ver}.tar.gz"
  source_sha256 '38c41f6698ef50fc7a1857ac69e29d95157bb1c4cf2111d9a14d03ed2cbf592e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/evolution_data_server-3.39.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/evolution_data_server-3.39.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/evolution_data_server-3.39.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/evolution_data_server-3.39.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '279a6cc3c29e1915ceac2643da60a058ad58f972d4690e5e9de724465bf1936a',
     armv7l: '279a6cc3c29e1915ceac2643da60a058ad58f972d4690e5e9de724465bf1936a',
       i686: 'c5fb88a2cc1e0919a793f183a0ccb513b8eb3e2f27eef682100347ffbdfc1c6b',
     x86_64: '159279d09980d97e288ef803ac8692671edc3fe9ee69014f0d9d12c470b80c30'
  })

  depends_on 'nss'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'vala' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'libsoup'
  depends_on 'gcr'
  depends_on 'libical'
  depends_on 'libsecret'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      CFLAGS='-pipe -flto=auto -I#{CREW_PREFIX}/include/gnu-libiconv' CXXFLAGS='-pipe -flto=auto -I#{CREW_PREFIX}/include/gnu-libiconv' \
      LDFLAGS='-flto=auto -L#{CREW_LIB_PREFIX}' \
      cmake #{CREW_CMAKE_OPTIONS} .. -G Ninja \
      -DENABLE_INTROSPECTION=OFF \
      -DENABLE_VALA_BINDINGS=OFF \
      -DENABLE_GTK_DOC=OFF \
      -DWITH_PHONENUMBER=OFF \
      -DWITH_NSPR_INCLUDES=#{CREW_PREFIX}/include/nspr \
      -DWITH_NSS_INCLUDES=#{CREW_PREFIX}/include/nss \
      -DENABLE_OAUTH2=OFF \
      -DENABLE_GOA=OFF \
      -DENABLE_WEATHER=OFF \
      -DENABLE_GOOGLE=OFF \
      -DENABLE_EXAMPLES=OFF \
      -DENABLE_CANBERRA=OFF \
      -DCMAKE_VERBOSE_MAKEFILE=ON"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
