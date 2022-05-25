require 'package'

class Npth < Package
  description 'nPth is a library to provide the GNU Pth API and thus a non-preemptive threads implementation.'
  homepage 'https://www.gnupg.org/related_software/npth/index.html'
  version '1.6'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/npth/npth-1.6.tar.bz2'
  source_sha256 '1393abd9adcf0762d34798dc34fdcf4d0d22a8410721e76f1e3afcd1daa4e2d1'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/npth/1.6_armv7l/npth-1.6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/npth/1.6_armv7l/npth-1.6-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/npth/1.6_i686/npth-1.6-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/npth/1.6_x86_64/npth-1.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0b1965d806030039b4ae11b025417bca7c21ad3959eca638e45cd4cd7d55f4ba',
     armv7l: '0b1965d806030039b4ae11b025417bca7c21ad3959eca638e45cd4cd7d55f4ba',
       i686: '1681a48ed502d65d3cb9f6ff8979eb009f8b83a94571b5077cd1e0744a75b5d8',
     x86_64: '1511822e81d1bf23d0c293e602d5cfa55cf4c00718f477e3b9344e4c27241cde'
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
