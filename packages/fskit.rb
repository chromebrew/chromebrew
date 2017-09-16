require 'package'

class Fskit < Package
  description 'Filesystem utility library and SDK'
  homepage 'https://github.com/jcnelson/fskit'
  version '2feb33'
  source_url 'https://github.com/jcnelson/fskit/archive/2feb33a84932980e4ed9691242537771dd4e80f4.tar.gz'
  source_sha256 'c3f0506eb5d9345e5ea91086ebb2b2afcee889eed55792715c8ab5e523e02031'

  depends_on 'attr'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
