require 'package'

class Libcheck < Package
  description 'A unit testing framework for C'
  homepage 'https://github.com/libcheck/check'
  version '0.11.0'
  source_url 'https://github.com/libcheck/check/releases/download/0.11.0/check-0.11.0.tar.gz'
  source_sha256 '24f7a48aae6b74755bcbe964ce8bc7240f6ced2141f8d9cf480bc3b3de0d5616'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.11.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.11.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcheck-0.11.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '362cace0e6df18c1f0964f9dc28f4b0a138b05c459288d4bafc50d08ac878105',
     armv7l: '362cace0e6df18c1f0964f9dc28f4b0a138b05c459288d4bafc50d08ac878105',
       i686: 'cf0682c591f52665cc76d19a8a1f804095d70c1117567f5356018f106662f5d2',
     x86_64: 'ec0188da2f01443784d9c674726b8279f99642e0a6cdef93dc257a8b1b1dc3e0',
  })

  depends_on 'libtool'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
