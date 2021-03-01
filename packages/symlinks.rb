require 'package'

class Symlinks < Package
  description 'scan/change symbolic links'
  homepage 'https://metadata.ftp-master.debian.org/changelogs//main/s/symlinks/symlinks_1.4-4_copyright'
  @_ver = '1.4-4'
  version @_ver
  compatibility 'all'
  source_url "https://salsa.debian.org/debian/symlinks/-/archive/debian/#{@_ver}/symlinks-debian-#{@_ver}.tar.bz2"
  source_sha256 'f4469a9f366ccfaa7273b1f78bd540b8a6fa96f8b2b81a95d131944fb77efdd4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/symlinks-1.4-4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/symlinks-1.4-4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/symlinks-1.4-4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/symlinks-1.4-4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '75676c7daebaa9a32ddf2053a47fde8e9cfb19ef774388b577b352514d98925d',
     armv7l: '75676c7daebaa9a32ddf2053a47fde8e9cfb19ef774388b577b352514d98925d',
       i686: '94c62cf190ad07a4c38c9fe15875ba819b17d9be306ed907aa4643a7a24d1e49',
     x86_64: '39fe5a53a1c557aa71cfd6d7760e069c0421931e3e5345c57696e1cf79bf8e39'
  })

  def self.patch
    system('for i in `cat debian/patches/series`; do patch -p 1 < debian/patches/$i; done')
    system "sed -i 's,/usr/local,#{CREW_DEST_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man8"
    FileUtils.install 'symlinks', "#{CREW_DEST_PREFIX}/bin/symlinks", mode: 0o755
    FileUtils.install 'symlinks.8', "#{CREW_DEST_MAN_PREFIX}/man8/symlinks.8", mode: 0o644
  end
end
