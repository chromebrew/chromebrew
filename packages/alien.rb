require 'package'

class Alien < Package
  description 'This program converts Linux packages between the rpm, deb, tgz and slp packages.'
  homepage 'https://sourceforge.net/projects/alien-pkg-convert/'
  version '8.95.8'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://deb.debian.org/debian/pool/main/a/alien/alien_8.95.8.tar.xz'
  source_sha256 '586a649bc9366acc15047d4c9f34e253208907142e12174eafb4f3704fea47a5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af014a083846b49d3641fb1a9a43ab3eaba1db736a1d4351897674205a88bdfa',
     armv7l: 'af014a083846b49d3641fb1a9a43ab3eaba1db736a1d4351897674205a88bdfa',
       i686: 'a910d11ebeb7b2dee53fdc567be042b41734b09b7bc237274c90745e6e6cfc3d',
     x86_64: '973b6adae5aa32b46acfa23541ac336e050b5a09919aa167194b3ce04b666362'
  })

  def self.build
    system 'perl Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
