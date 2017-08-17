require 'package'

class Libatomic_ops < Package
  description 'Atomic memory update operations portable implementation'
  homepage 'https://github.com/ivmai/libatomic_ops'
  version '7.6.0'
  source_url 'https://github.com/ivmai/libatomic_ops/releases/download/v7.6.0/libatomic_ops-7.6.0.tar.gz'
  source_sha256 '8e2c06d1d7a05339aae2ddceff7ac54552854c1cbf2bb34c06eca7974476d40f'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
