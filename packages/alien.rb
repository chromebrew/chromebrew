require 'package'

class Alien < Package
  description 'This program converts linux packages between the rpm, deb, tgz and slp packages.'
  homepage 'https://sourceforge.net/projects/alien-pkg-convert/'
  @_ver = '8.95'
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/alien-pkg-convert/release/alien_8.95.tar.xz'
  source_sha256 '37a22587c33810feab323474bdadbf969fda2eb4e720b2ca01b40d82d6f71a17'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af014a083846b49d3641fb1a9a43ab3eaba1db736a1d4351897674205a88bdfa',
     armv7l: 'af014a083846b49d3641fb1a9a43ab3eaba1db736a1d4351897674205a88bdfa',
       i686: 'cb24420a1a15f2ebd445261ce7b53cb026e7e25d5a3e6036dacf5572b5f233cf',
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
