require 'package'

class Libmad < Package
  description 'MAD is a high-quality MPEG audio decoder.'
  homepage 'https://www.underbit.com/products/mad/'
  version '0.15.1b-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/libm/libmad/libmad_0.15.1b.orig.tar.gz'
  source_sha256 'bbfac3ed6bfbc2823d3775ebb931087371e142bb0e9bb1bee51a76a6e0078690'

  def self.patch
    downloader 'https://httpredir.debian.org/debian/pool/main/libm/libmad/libmad_0.15.1b-10.diff.gz'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('libmad_0.15.1b-10.diff.gz') ) == 'dfeabd5d2398bf902660edc31f87ad40600f0aa732b946f864d8ee6bbf56a99c'
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
