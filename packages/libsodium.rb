require 'package'

class Libsodium < Package
  description 'A modern, portable, easy to use crypto library'
  homepage 'https://libsodium.org'
  version '1.0.18'
  source_url 'https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz'
  source_sha256 '6f504490b342a4f8a4c4a02fc9b866cbef8622d5df4e5452b46be121e46636c1'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
