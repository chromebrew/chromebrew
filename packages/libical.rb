require 'package'

class Libical < Package
  description 'An open source reference implementation of the icalendar data type and serialization format'
  version '3.0.9'
  compatibility 'all'
  source_url 'https://github.com/libical/libical/releases/download/v3.0.9/libical-3.0.9.tar.gz'
  source_sha256 'bd26d98b7fcb2eb0cd5461747bbb02024ebe38e293ca53a7dfdcb2505265a728'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libical-3.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libical-3.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libical-3.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libical-3.0.9-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7db2461fee6be357f39abd270cfad5f20aa2e0d40f65a3310f1d2cc755c50e5e',
     armv7l: '7db2461fee6be357f39abd270cfad5f20aa2e0d40f65a3310f1d2cc755c50e5e',
       i686: '15749b91f620d4f108c6c73ce3a23075621a13728348d401ae499b1db047b747',
     x86_64: 'd3ebd14fbd5b34f1c0347dfb21e6b278a6a7131fb9367a1be0e53d23cac755ac'
  })

  depends_on 'glib'
  depends_on 'icu4c'
  depends_on 'gtk_doc' => ':build'
  depends_on 'vala' => ':build'
  depends_on 'gobject_introspection' => ':build'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      cmake #{CREW_CMAKE_OPTIONS} .. -G Ninja \
      -DGOBJECT_INTROSPECTION=true \
      -DICAL_GLIB_VAPI=true \
      -DICAL_BUILD_DOCS=false \
      -DLIBICAL_BUILD_TESTING=false"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
