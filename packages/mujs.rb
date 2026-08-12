require 'package'

class Mujs < Package
  description 'An embeddable Javascript interpreter in C'
  homepage 'https://mujs.com/'
  version '1.3.10'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/ArtifexSoftware/mujs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20f19d7d4182dfa96effdccc8369523d29e503669035303e81c0593880c229ad',
     armv7l: '20f19d7d4182dfa96effdccc8369523d29e503669035303e81c0593880c229ad',
       i686: '44d22160fc5647c3975df5fd695126ec2f73dad447073b358d09dadf69d95715',
     x86_64: 'eeeb9f2a6584cb2a1e64c2f23629417afd466ed5e998ed2720dd80187defe607'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'readline' => :executable

  def self.build
    system 'make', 'release'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install-shared'
  end
end
