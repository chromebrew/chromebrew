require 'package'

class Libical < Package
  description 'An open source reference implementation of the icalendar data type and serialization format'
  version '3.0.8.99' # 3.0.8 doesn't compile.
  compatibility 'all'
  source_url 'https://github.com/libical/libical/archive/07dc84fb0d5e50fb493005e10fa41930111da48f.zip'
  source_sha256 '5fdf39b0ea654589bf2e9aa88ef1b0206c18aa6987f5a4299db3748e8b1eefd6'

  depends_on 'glib'
  depends_on 'icu4c'
  depends_on 'gtk_doc' => ':build'
  depends_on 'vala' => ':build'
  depends_on 'gobject_introspection' => ':build'

  def self.build
  Dir.mkdir 'build'
    Dir.chdir 'build' do
    system "cmake #{CREW_CMAKE_OPTIONS} .. -G Ninja \
    -DGOBJECT_INTROSPECTION=true \
    -DICAL_GLIB_VAPI=true \
    -DICAL_BUILD_DOCS=false \
    -DLIBICAL_BUILD_TESTING=false"
    end
  system "ninja -C build"
  end
  
  def self.install
  system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
