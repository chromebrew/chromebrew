require 'package'

class Cbase < Package
  description 'cbase is a C library of useful functions that simplify systems software development on System V UNIX.'
  homepage 'http://www.hyperrealm.com/oss_cbase.shtml'
  version '1.3.7-2'
  source_url 'http://www.hyperrealm.com/packages/cbase-1.3.7.tar.gz'
  source_sha256 'c4d155686ac2e9d1480319de311967fadad745a6ab6971d53d495d9a9e52dc47'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cbase-1.3.7-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7239675f8e4b748002410ec794cd23b0cdc6c81610eb4b8fa943ed8a3734c32d',
     armv7l: '7239675f8e4b748002410ec794cd23b0cdc6c81610eb4b8fa943ed8a3734c32d',
       i686: 'a1c2d4270c5efa6743cfe6c3166c62ec70d09c992492c1879eaac3df0a600f19',
     x86_64: '48d4d2a501f9c1436eeb4f9352e5e27c1e53dd172cab362510e9c5f118cbc10c',
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
