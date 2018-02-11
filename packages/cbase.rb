require 'package'

class Cbase < Package
  description 'cbase is a C library of useful functions that simplify systems software development on System V UNIX.'
  homepage 'http://www.hyperrealm.com/oss_cbase.shtml'
  version '1.3.7-2'
  source_url 'http://www.hyperrealm.com/packages/cbase-1.3.7.tar.gz'
  source_sha256 'c4d155686ac2e9d1480319de311967fadad745a6ab6971d53d495d9a9e52dc47'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'expat'
  
  def self.build
    # fix error on arm architecture
    case ARCH
      when 'armv7l','aarch64'
        Dir.chdir("lib") do
          system "sed -i '376c if (&vp == NULL)' strings.c"  # change from   if(!vp)   to    if (&vp == NULL),  tested on armv7l   
        end
    end
    
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
