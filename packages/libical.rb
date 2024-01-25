require 'package'

class Libical < Package
  description 'An open source reference implementation of the icalendar data type and serialization format'
  homepage 'https://github.com/libical/libical'
  version '3.0.10'
  license 'MPL-2.0 or LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libical/libical/releases/download/v3.0.10/libical-3.0.10.tar.gz'
  source_sha256 'f933b3e6cf9d56a35bb5625e8e4a9c3a50239a85aea05ed842932c1a1dc336b4'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'eaf30d94276f73f41c57f4c4ef520d90db8dd26c6fabd87ec06eb427d7630c1f',
     armv7l: 'eaf30d94276f73f41c57f4c4ef520d90db8dd26c6fabd87ec06eb427d7630c1f',
     x86_64: '4183f8666361ccb3c4c41e41ec1a17a649d1e432836a55a3aeb56ef2d0976f05'
  })

  depends_on 'glib'
  depends_on 'gtk_doc' => :build
  depends_on 'icu4c'
  depends_on 'vala' => :build
  depends_on 'gobject_introspection' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake #{CREW_CMAKE_OPTIONS} .. -G Ninja \
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
