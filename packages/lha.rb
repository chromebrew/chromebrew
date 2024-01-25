require 'package'

class Lha < Package
  description 'LHa for UNIX is a console-based utility that uncompresses and compresses .lha packages.'
  homepage 'https://lha.osdn.jp/'
  version '2695022'
  license 'lha'
  compatibility 'all'
  source_url 'https://github.com/jca02266/lha.git'
  git_hashtag '26950220c9c7590fd603ecaa54a12a52371affed'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a9e93c81eef64714252d453f98843a2d6b00c43bbcc9b4c67c3aabeb8365db50',
     armv7l: 'a9e93c81eef64714252d453f98843a2d6b00c43bbcc9b4c67c3aabeb8365db50',
       i686: 'f3f0e76166650dafe0874af2b10b650f3e826503e1be6cacae4275d03fe6a918',
     x86_64: 'b5ac02857046c1673acdb928c7a189ee350d9b0babdaaea1661c39fc81328590'
  })

  depends_on 'glibc_lib' # R

  def self.build
    system 'autoreconf -sif'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
