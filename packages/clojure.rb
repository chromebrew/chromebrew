require 'package'

class Clojure < Package
  description 'Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.'
  homepage 'https://clojure.org/'
  version '1.9.0'
  source_url 'https://raw.githubusercontent.com/clojure/clojure/clojure-1.9.0/readme.txt'
  source_sha256 'eed803be567d7a3dd50c72ebb9622718c84ca32100c5cb246efd1df9f3038784'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'jdk8'
  depends_on 'rlwrap'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/clojure"
    system "curl -O https://download.clojure.org/install/linux-install-1.9.0.326.sh"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('linux-install-1.9.0.326.sh') ) == 'ced0fa4bdb3c2b6901239b0b7fd57471920d35d6e422e5c47dc09a225a222c8c'
    system "sed -i 's,/usr/local/bin,#{CREW_DEST_PREFIX}/bin,g' linux-install-1.9.0.326.sh"
    system "sed -i 's,/usr/local/lib,#{CREW_DEST_PREFIX}/share/clojure,g' linux-install-1.9.0.326.sh"
    system "chmod +x linux-install-1.9.0.326.sh"
    system "./linux-install-1.9.0.326.sh"
    system "sed -i 's,install_dir=#{CREW_DEST_PREFIX},install_dir=#{CREW_PREFIX},' #{CREW_DEST_PREFIX}/bin/clojure"
  end
end
