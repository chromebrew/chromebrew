require 'package'

class Cbase < Package
  description 'cbase is a C library of useful functions that simplify systems software development on System V UNIX.'
  homepage 'http://www.hyperrealm.com/oss_cbase.shtml'
  version '1.3.7-1'
  source_url 'http://www.hyperrealm.com/packages/cbase-1.3.7.tar.gz'
  source_sha256 'c4d155686ac2e9d1480319de311967fadad745a6ab6971d53d495d9a9e52dc47'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
