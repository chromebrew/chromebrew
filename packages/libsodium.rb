require 'package'

class Libsodium < Package
  description 'A modern, portable, easy to use crypto library'
  homepage 'https://libsodium.org'
  version '1.0.16'
  source_url 'https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz'
  source_sha256 'eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533'

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
