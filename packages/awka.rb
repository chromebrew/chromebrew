require 'package'

class Awka < Package
  description 'Awka is an awk to ANSI C compiler'
  homepage 'https://project.noyesno.net/awka/'
  version '0.7.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/noyesno/awka/archive/refs/tags/v0.7.6.tar.gz'
  source_sha256 '0a221e2184be529893a59ef994c6cbae6e02d922faae326249a9c8d88f0826b9'

  def self.build
    system "./configure --prefix=#{CREW_DEST_PREFIX}"
    system "make"
  end
  
  def self.install
    system "make", "install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/"
    FileUtils.mv "#{CREW_DEST_PREFIX}/man/", "#{CREW_DEST_PREFIX}/share/"
    
    
    case CREW_LIB_SUFFIX
    when '64'
      FileUtils.mkdir_p "#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}"
      FileUtils.mv Dir.glob("#{CREW_DEST_PREFIX}/lib/*"), "#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}"
    end
  end
  
  def self.check
    system "make check"
  end
end
