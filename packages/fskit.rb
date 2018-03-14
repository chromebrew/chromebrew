require 'package'

class Fskit < Package
  description 'Filesystem utility library and SDK'
  homepage 'https://github.com/jcnelson/fskit'
  version 'dd9a8'
  source_url 'https://github.com/jcnelson/fskit/archive/dd9a8dc844b81afc63e5067397786a32ecb66008.tar.gz'
  source_sha256 'fe682890ebab9226d65fc6ebfb8b3619c0d5a93e3161787cea9d01ad23d3a83a'


  depends_on 'attr'

    
  def self.patch
    # for x86_64 architecture, build library should be modified to #{CREW_PREFIX}/lib64
    if ARCH == "x86_64"
       puts "Patch build file for x86_64 ..." 
        `sed -i -- 's/lib/lib64/g' buildconf.mk` # replace lib by lib64
    end
  end
    
  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
