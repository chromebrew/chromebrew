require 'package'

class Pagein < Package
  description 'Pagein is a tool that forces pages that are in swap to be paged in back to memory.'
  homepage 'https://github.com/ColinIanKing/pagein'
  version '0.01.11'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/pagein.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e0735324b3abbdfe66b3964b8a4547bdd59d9506a6124c2061784ff7faee9af',
     armv7l: '9e0735324b3abbdfe66b3964b8a4547bdd59d9506a6124c2061784ff7faee9af',
       i686: 'b3afc0f2ea3bf569f2021edaa7448370b3ad3abeee617813c3960512d22d04cf',
     x86_64: '0dfd7febe0c4767d2b0adbffa837e6d22f87203b14b9be00c87a4e2a0935fc39'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system 'make',
           "BINDIR=#{CREW_PREFIX}/bin",
           "MANDIR=#{CREW_MAN_PREFIX}/man1"
  end

  def self.install
    system 'make',
           "DESTDIR=#{CREW_DEST_DIR}",
           "BINDIR=#{CREW_PREFIX}/bin",
           "MANDIR=#{CREW_MAN_PREFIX}/man1",
           'install'
  end
end
