require 'package'

class Ncat < Package
  description 'Ncat - Netcat for the 21st Century - a modern netcat with extra features from the makers of nmap.'
  homepage 'https://nmap.org/ncat'
  version '7.60'
  source_url 'https://nmap.org/dist/nmap-7.60.tar.bz2'
  source_sha256 'a8796ecc4fa6c38aad6139d9515dc8113023a82e9d787e5a5fb5fa1b05516f21'

  binary_url ({
    x86_64: 'https://www.clift.org/fred/chromebrew/ncat-7.60-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '5660ea321436f1b9642d318a77e9b0b5c379825ac0611daaf5f82dd794753598',
  })

  depends_on 'buildessential' => :build
  depends_on 'openssl' 
  depends_on 'filecmd' => :build   #configure uses file 

  def self.build
    #fixup "/usr/bin/file" -> "/usr/local/bin/file" in the configure scripts
    system "sed -i s#/usr/bin/file#/usr/local/bin/file#g libdnet-stripped/configure"
    system "./configure"
    system "cd ncat && make"
  end

  def self.install
    system "cd ncat && make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
