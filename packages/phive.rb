require 'package'

class Phive < Package
  description 'The PHAR Installation and Verification Environment (PHIVE)'
  homepage 'https://phar.io/'
  version '0.9.0'
  source_url 'https://github.com/phar-io/phive/archive/0.9.0.tar.gz'
  source_sha256 '711659b2293015c1bc81755bb56746fc86f1c6c6c3b87eaaddaa56d29c86c0ad'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'composer'
  depends_on 'gnupg'

  def self.install
    system "composer install"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/phive"
    system "cp -r . #{CREW_DEST_PREFIX}/share/phive"
    system "ln -s #{CREW_PREFIX}/share/phive/phive #{CREW_DEST_PREFIX}/bin/phive"
  end
end
