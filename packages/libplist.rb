require 'package'

class Libplist < Package
  description 'A library to handle Apple Property List format'
  homepage 'http://www.libimobiledevice.org/'
  version '2.1.0'
  compatibility 'all'
  source_url 'https://github.com/libimobiledevice/libplist/archive/2.1.0.tar.gz'
  source_sha256 '4b33f9af3f9208d54a3c3e1a8c149932513f451c98d1dd696fe42c06e30b7f03'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libplist-2.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libplist-2.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libplist-2.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libplist-2.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'adca559671e694422de5f311b9c968d4e7f5fc45aae8c1c9140e825741475d26',
     armv7l: 'adca559671e694422de5f311b9c968d4e7f5fc45aae8c1c9140e825741475d26',
       i686: '11f60dc59c427f286b717fcd63ada445effc478c5895f51130128a6b1ff5418e',
     x86_64: 'd6580afa2ec93f6a41f95e31cb86dd5dd7828f09a5091323f2fe6a4ee90a4e20',
  })

  depends_on 'glib'

  def self.build
    system "PYTHON=#{CREW_PREFIX}/bin/python3 ./autogen.sh CC=gcc CXX=g++ #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
