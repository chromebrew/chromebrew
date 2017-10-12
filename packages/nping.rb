require 'package'

class Nping < Package
  description 'Nping is part of the nmap suite - a network diagnostics tool`.'
  homepage 'https://nmap.org/nping/'
  version '7.60'
  source_url 'https://nmap.org/dist/nmap-7.60.tar.bz2'
  source_sha256 'a8796ecc4fa6c38aad6139d9515dc8113023a82e9d787e5a5fb5fa1b05516f21'

  binary_url ({
    x86_64: 'https://www.clift.org/fred/chromebrew/nping-7.60-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '208ed7878333564c9ea15d82174d542ea1c6e5d93b2ef0219000c5b8de695eb2',
  })

  depends_on 'buildessential' => :build
  depends_on 'openssl' 
  depends_on 'filecmd' => :build   #configure uses file 

  def self.build
    #fixup "/usr/bin/file" -> "/usr/local/bin/file" in the configure scripts
    system "sed -i s#/usr/bin/file#/usr/local/bin/file#g libdnet-stripped/configure"

    # make files in the project dont have the right dependencies to build this by itself
    # so just make the whole thing and then install nping later. not effecient, but
    # more likely to work than making a bunch of Makefile dependency edits
    system "./configure && make"
  end

  def self.install
    system "cd nping && make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
