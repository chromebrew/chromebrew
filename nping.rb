require 'package'

class Nping < Package
  description 'Nping is part of the nmap suite - a network diagnostics tool`.'
  homepage 'https://nmap.org/nping/'
  version '7.60'
  source_url 'https://nmap.org/dist/nmap-7.60.tar.bz2'
  source_sha256 'a8796ecc4fa6c38aad6139d9515dc8113023a82e9d787e5a5fb5fa1b05516f21'

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncat-7.60-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '208ed7878333564c9ea15d82174d542ea1c6e5d93b2ef0219000c5b8de695eb2',
  })

  depends_on 'buildessential' => :build
  depends_on 'filecmd' => :build   #configure uses file 

  def self.build
    #fixup "/usr/bin/file" -> "file" in the configure script
    
    system "sed -i s#/usr/bin/file##{CREW_PREFIX}/bin/file#g libdnet-stripped/configure"

    #without-zenmap in configure removes openssl dependency
    system "./configure --without-zenmap --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"

    # Make files in the project dont have the right dependencies to build this by itself
    # so just make the whole thing and then install nping - not effecient, but
    # more likely to work than a bunch of Makefile dependency edits
    system "make"
  end

  def self.install
    system "cd nping && make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
