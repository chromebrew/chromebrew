require 'package'

class Mawk < Package
  description 'mawk is a POSIX compatible interpreter of the awk language faster than gawk.'
  homepage 'https://invisible-island.net/mawk/'
  version '1.3.4-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/mawk/-/archive/debian/1.3.4.20200120-2/mawk-debian-1.3.4.20200120-2.tar.bz2'
  source_sha256 '61bd21eb4a62b6e1ff199d4c7cb9f9e1cc882ac24e75ad2dab04e190e87656dc'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mawk/1.3.4-1_armv7l/mawk-1.3.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mawk/1.3.4-1_armv7l/mawk-1.3.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mawk/1.3.4-1_i686/mawk-1.3.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mawk/1.3.4-1_x86_64/mawk-1.3.4-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7260801b0b8a202d56853c8ca65c30918a7a67e5eea2ca500b2373f276f5d590',
     armv7l: '7260801b0b8a202d56853c8ca65c30918a7a67e5eea2ca500b2373f276f5d590',
       i686: '8bc8d6247fe663b33c9f318900ac96a851dce20845758dfa2f6c44cd16add93d',
     x86_64: '5cfce5981ae0c1d388f6d716cc6205485877c593bee96ff44005ed0fba0c6fc3'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/mawk", "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
