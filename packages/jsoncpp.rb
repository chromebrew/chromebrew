require 'package'

class Jsoncpp < Package
  description 'A C++ library for interacting with JSON.'
  homepage 'https://github.com/open-source-parsers/jsoncpp'
  version '1.8.4'
  compatibility 'all'
  source_url 'https://github.com/open-source-parsers/jsoncpp/archive/1.8.4.tar.gz'
  source_sha256 'c49deac9e0933bcb7044f08516861a2d560988540b23de2ac1ad443b219afdb6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jsoncpp-1.8.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jsoncpp-1.8.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jsoncpp-1.8.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jsoncpp-1.8.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b8b28dfbdb1a30ba094d9c694e2f7a3b27d3cadbdaa463173baa4f813630f2c',
     armv7l: '5b8b28dfbdb1a30ba094d9c694e2f7a3b27d3cadbdaa463173baa4f813630f2c',
       i686: 'd32ae2439fe8fdeae7c61d58d2b8d55d97b65ac44dfa7cfc0e4840455cb48acb',
     x86_64: '0ae17bea20bcd7daeb5a80b45e9b49601c288a7c75077c26c3bb64d8d1ea8dd5',
  })

  depends_on 'meson'

  def self.build
    system "meson --prefix #{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --buildtype release \
           --default-library shared . build"
  end

  def self.check
    system 'ninja -v -C build test'
  end

  def self.install
    Dir.chdir 'build' do
      system "DESTDIR=#{CREW_DEST_DIR} ninja install"
    end
  end
end
