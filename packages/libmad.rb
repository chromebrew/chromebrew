require 'package'

class Libmad < Package
  description 'MAD is a high-quality MPEG audio decoder.'
  homepage 'https://www.underbit.com/products/mad/'
  version '0.15.1b-1'
  compatibility 'all'
  license 'GPL-2'
  source_url 'https://httpredir.debian.org/debian/pool/main/libm/libmad/libmad_0.15.1b.orig.tar.gz'
  source_sha256 'bbfac3ed6bfbc2823d3775ebb931087371e142bb0e9bb1bee51a76a6e0078690'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmad/0.15.1b-1_armv7l/libmad-0.15.1b-1-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmad/0.15.1b-1_armv7l/libmad-0.15.1b-1-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmad/0.15.1b-1_i686/libmad-0.15.1b-1-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmad/0.15.1b-1_x86_64/libmad-0.15.1b-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fa97940e20089f3c79388d13a3e05f3d527cd59641fdf09afdf8aea4ea379523',
      armv7l: 'fa97940e20089f3c79388d13a3e05f3d527cd59641fdf09afdf8aea4ea379523',
        i686: '71822bdcb2d8c25e0005bd0d29b61c9b0b2f592a9e07be5e51783eba4432dbe8',
      x86_64: '10dca6998f2fdab04234345da0ed00a6c9d9705d0e139032f5d297f99d31ae7b'
  })

  def self.patch
    downloader 'https://httpredir.debian.org/debian/pool/main/libm/libmad/libmad_0.15.1b-10.diff.gz', 'dfeabd5d2398bf902660edc31f87ad40600f0aa732b946f864d8ee6bbf56a99c'

    system 'zcat libmad_0.15.1b-10.diff.gz | patch -Np1'
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --enable-accuracy \
            --disable-debugging"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
