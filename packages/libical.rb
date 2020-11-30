require 'package'

class Libical < Package
  description 'An open source reference implementation of the icalendar data type and serialization format'
  version '3.0.8.99' # 3.0.8 doesn't compile.
  compatibility 'all'
  source_url 'https://github.com/libical/libical/archive/07dc84fb0d5e50fb493005e10fa41930111da48f.zip'
  source_sha256 '5fdf39b0ea654589bf2e9aa88ef1b0206c18aa6987f5a4299db3748e8b1eefd6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libical-3.0.8.99-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libical-3.0.8.99-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libical-3.0.8.99-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libical-3.0.8.99-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ff814e2b53f6c707a029f74895c90cde0b4bf6b8156dfbc03ecb9f49d34dc919',
     armv7l: 'ff814e2b53f6c707a029f74895c90cde0b4bf6b8156dfbc03ecb9f49d34dc919',
       i686: '1a9abe4217cf37eefd0e09ced2203651dd283157072efb850b7bdcb69ebdee39',
     x86_64: 'f21f8c0273497d6906a087cfad00d0ab51f588121d0f0564a391364caabc9781',
  })

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
