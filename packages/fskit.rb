require 'package'

class Fskit < Package
  description 'Filesystem utility library and SDK'
  homepage 'https://github.com/jcnelson/fskit'
  version '1.0.0'
  source_url 'https://github.com/flyingP0tat0/fskit/archive/1.0.0.tar.gz'
  source_sha256 '3a1d49d433870fa27e498ab25e49280ce788f401cdd0afb27f29d99ba0e117c2'

  depends_on 'attr'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
