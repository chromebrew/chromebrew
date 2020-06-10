require 'package'

class Libffi < Package
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.2.1-2'
  compatibility 'all'
  source_url 'ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz'
  source_sha256 'd06ebb8e1d9a22d19e38d63fdb83954253f39bedc5d46232a05645685722ca37'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.2.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.2.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.2.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.2.1-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2af9d89eeb28be4422b2a75218414de25e8d1e7c09efa9fb37660fbd6b6969bd',
     armv7l: '2af9d89eeb28be4422b2a75218414de25e8d1e7c09efa9fb37660fbd6b6969bd',
       i686: '32d5df74da5e018709c7c0ca7cf17504face5b951af7ed1c8267980a8ac20d6e',
     x86_64: '92d528749d53e5140e510864458a4ff46521b2c17c2311f05077707413965e9e',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic", "--disable-debug", "--disable-dependency-tracking"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # system "make check"         # DejaGNU required
  end
end
