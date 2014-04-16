require 'package'

class Astyle < Package
  version '2.04'
  source_url 'http://downloads.sourceforge.net/project/astyle/astyle/astyle%202.04/astyle_2.04_linux.tar.gz?r=&ts=1396574312&use_mirror=softlayer-dal'
  source_sha1 '8d7701afa3ecb7fb24d3647d8b278dcf17f3ae3e'
  
  depends_on "buildessential"
  
  def self.build
    system "make","-C","build/gcc","release"
  end

  def self.install
  	system "mkdir","-p",CREW_DEST_DIR+"/usr/local/bin"
    system "cp","./build/gcc/bin/astyle",CREW_DEST_DIR+"/usr/local/bin/AStyle"
  end
end