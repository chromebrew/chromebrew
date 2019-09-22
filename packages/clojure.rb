require 'package'

class Clojure < Package
  description 'Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.'
  homepage 'https://clojure.org/'
  version '1.10.1.469'
  source_url 'https://raw.githubusercontent.com/clojure/clojure/clojure-1.10.1/readme.txt'
  source_sha256 '3487545874a31b2c568397be221eb5c9070e220cbf741f1eb4819937200d21a5'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'jdk8'
  depends_on 'rlwrap'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/clojure"
    system "curl -O https://download.clojure.org/install/linux-install-#{self.version}.sh"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("linux-install-#{self.version}.sh") ) == '265e46d492b682cecc346ef018076a3181203dfe5e3dbe455b0f7feab51df70f'
    system "chmod +x linux-install-#{self.version}.sh"
    system "./linux-install-#{self.version}.sh --prefix #{CREW_DEST_PREFIX}"
    system "sed -i 's,install_dir=#{CREW_DEST_PREFIX},install_dir=#{CREW_PREFIX},' #{CREW_DEST_PREFIX}/bin/clojure"
  end
end
