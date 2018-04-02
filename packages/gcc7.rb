require 'package'

class Gcc7 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '7.3.0'
  source_url 'https://github.com/gcc-mirror/gcc/archive/gcc-7_3_0-release.tar.gz'
  source_sha256 'af11c397296cab69996723b9d828c98a9bb749447ac8f7ed67458bcdb60311ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9f7af4ee52a48df0b2a88be4a38331831666a430a82c01eab05bfa7d6851b46d',
     armv7l: '9f7af4ee52a48df0b2a88be4a38331831666a430a82c01eab05bfa7d6851b46d',
       i686: '40972578f1f38a3366233314da5b9d219d172d7fdc0a62a5b324161fa076e188',
     x86_64: '075de22aabb8b9ea9e1acb515b360284934ffcd50fa5aa45e0cef15e56094c9f',
  })

  depends_on 'unzip' => :build
  depends_on 'gawk'
    
  def self.build
    ENV["LIBRARY_PATH"] = "#{CREW_LIB_PREFIX}"
    system "mkdir -p objdir"
    Dir.chdir("objdir") do
      case ARCH
        when 'armv7l' || 'aarch64'
          system "../configure",
                 "--prefix=#{CREW_PREFIX}",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 "--build=armv7l-cros-linux-gnueabihf",
                 "--host=armv7l-cros-linux-gnueabihf",
                 "--target=armv7l-cros-linux-gnueabihf",
                 "--enable-checking=release",
                 "--enable-languages=c,c++,fortran",
                 "--disable-multilib",
                 "--enable-threads=posix",
                 "--disable-bootstrap",
                 "--disable-libmpx",
                 "--disable-static",
                 "--program-suffix=-7.3",
                 "--with-arch=armv7-a",
                 "--with-tune=cortex-a15",
                 "--with-fpu=neon",
                 "--with-float=hard"
        when "x86_64"
          system "../configure",
                 "--prefix=#{CREW_PREFIX}",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 "--build=#{ARCH}-cros-linux-gnu",
                 "--host=#{ARCH}-cros-linux-gnu",
                 "--target=#{ARCH}-cros-linux-gnu",
                 "--enable-checking=release",
                 "--enable-languages=c,c++,fortran",
                 "--disable-multilib",
                 "--enable-threads=posix",
                 "--disable-bootstrap",
                 "--disable-libmpx",
                 "--disable-static",
                 "--program-suffix=-7.3",
                 "--with-arch-64=x86-64"
        when "i686"
          system "../configure",
                 "--prefix=#{CREW_PREFIX}",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 "--build=#{ARCH}-cros-linux-gnu",
                 "--host=#{ARCH}-cros-linux-gnu",
                 "--target=#{ARCH}-cros-linux-gnu",
                 "--enable-checking=release",
                 "--enable-languages=c,c++,fortran",
                 "--disable-multilib",
                 "--enable-threads=posix",
                 "--disable-bootstrap",
                 "--disable-libmpx",
                 "--disable-static",
                 "--program-suffix=-7.3",
                 "--with-arch-32=i686"
      end
        system "make"
    end
  end

  def self.install
    Dir.chdir("objdir") do
	    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
    
end
