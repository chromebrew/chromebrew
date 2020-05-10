require 'package'

class Cbase < Package
  description 'cbase is a C library of useful functions that simplify systems software development on System V UNIX.'
  homepage 'http://www.hyperrealm.com/oss_cbase.shtml'
  version '1.3.7-3'
  compatibility 'all'
  source_url 'http://www.hyperrealm.com/packages/cbase-1.3.7.tar.gz'
  source_sha256 'c4d155686ac2e9d1480319de311967fadad745a6ab6971d53d495d9a9e52dc47'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b3e31a3e497c1cd251a8fb20e135fbb38f18d42eb3353bc24039f69f0776b55b',
     armv7l: 'b3e31a3e497c1cd251a8fb20e135fbb38f18d42eb3353bc24039f69f0776b55b',
       i686: 'c27b41ffa87627436fd4874cede6d5f9cfc0b028aa9787579efc159866551c58',
     x86_64: '386d2a466b6a4412a9e655a94c04769e7705e1049aa5b0a4b3ec438dd36f8b55',
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
    
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
