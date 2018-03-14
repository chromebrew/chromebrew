require 'package'

class Fskit < Package
  description 'Filesystem utility library and SDK'
  homepage 'https://github.com/jcnelson/fskit'
  version '2feb33-1'
  source_url 'https://github.com/jcnelson/fskit/archive/2feb33a84932980e4ed9691242537771dd4e80f4.tar.gz'
  source_sha256 'c3f0506eb5d9345e5ea91086ebb2b2afcee889eed55792715c8ab5e523e02031'


  depends_on 'attr'

    
  def self.patch
    # for x86_64 architecture, build library should be modified to #{CREW_PREFIX}/lib64
    if ARCH == "x86_64"
       puts "Patch build file for x86_64 ..."
      `sed -i -- 's/lib/lib64/g' buildconf.mk`  # replace lib by lib64 
    end
  end
    
  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
