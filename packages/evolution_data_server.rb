require 'package'

class Evolution_data_server < Package
  description 'Centralized access to appointments and contacts'
  @_ver = '3.39.3'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/evolution-data-server/archive/#{@_ver}.tar.gz"
  source_sha256 'd789b6dc403d35902b3b6cdcebff31880d2773b1829fbdc561c59a71453eaab9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/evolution_data_server-3.39.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/evolution_data_server-3.39.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/evolution_data_server-3.39.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/evolution_data_server-3.39.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cf89c1f0ee6aaec68cee3dc6d5e9261a715b1e074ea1613f474976f9e8db376e',
     armv7l: 'cf89c1f0ee6aaec68cee3dc6d5e9261a715b1e074ea1613f474976f9e8db376e',
       i686: 'afe9ca339c2f242a40754f9a382a7ea07c616bdb50a30d65a4cade0ef641d8f4',
     x86_64: 'cb36117f9ffaf564b84c0ec60c15c4c08a9e7d07584daa54dc859b5d281a8f17'
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
      -DWITH_PHONENUMBER=OFF"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
