require 'package'

class Datamash < Package
  description 'GNU Datamash is a command-line program which performs basic numeric, textual and statistical operations on input textual data files.'
  homepage 'https://www.gnu.org/software/datamash'
  version '1.8'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/datamash/datamash-1.8.tar.gz'
  source_sha256 '7ad97e8c7ef616dd03aa5bd67ae24c488272db3e7d1f5774161c18b75f29f6fd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ccf1a94c18095f1b5c84725da2eed415b10d307b1c5f15bbef764d81df336e8',
     armv7l: '0ccf1a94c18095f1b5c84725da2eed415b10d307b1c5f15bbef764d81df336e8',
       i686: 'fc99683d9d77b22ae45485acf94c8bc51f85cae2177f052f96b625bdbaacb7ba',
     x86_64: '2ef1f4edaa2a041b70fc20c5e3f46576e9bd4b9ac6418d6a4702c756a5d6e088'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
