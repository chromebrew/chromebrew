require 'package'

class Cabextract < Package
  description 'cabextract is Free Software for extracting Microsoft cabinet files, also called .CAB files.'
  homepage 'https://www.cabextract.org.uk/'
  version '1.6'
  source_url 'https://www.cabextract.org.uk/cabextract-1.6.tar.gz'
  source_sha256 'cee661b56555350d26943c5e127fc75dd290b7f75689d5ebc1f04957c4af55fb'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/cabextract-1.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/cabextract-1.6-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/cabextract-1.6-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/cabextract-1.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2b80539b495ab1ed9a023da2b2d87310b1c58ceae177e6c541b93ccd77901517',
     armv7l: '2b80539b495ab1ed9a023da2b2d87310b1c58ceae177e6c541b93ccd77901517',
       i686: '77ce30a3079c392ca49760076c1efc99ceebaee932178434f8004a0bccee9a00',
     x86_64: '75095476870a5fa3b4cb1d291f336b8132727ffbca7c35e0424aa2ccb38c4afd',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
