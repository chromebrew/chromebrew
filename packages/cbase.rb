require 'package'

class Cbase < Package
  description 'cbase is a C library of useful functions that simplify systems software development on System V UNIX.'
  homepage 'http://www.hyperrealm.com/oss_cbase.shtml'
  version '1.3.7-1'
  source_url 'http://www.hyperrealm.com/packages/cbase-1.3.7.tar.gz'
  source_sha256 'c4d155686ac2e9d1480319de311967fadad745a6ab6971d53d495d9a9e52dc47'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '9ce31b80b473652f8da8ede23294d5a8c7fb4b4d9c678d9452a3f8d77a91a8a0',
     x86_64: '2f504105cc4c0aef846e0d5fc272a7baf919517f40cc19a86e55b59c12ab0d61',
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
