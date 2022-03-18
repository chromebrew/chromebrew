require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library, with APNG support packaged in.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.37'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/libpng/files/libpng16/1.6.37/libpng-1.6.37.tar.xz'
  source_sha256 '505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37_i686/libpng-1.6.37-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37_x86_64/libpng-1.6.37-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '1cff84fce9bfa50410881ceb77514c5b44a72220d06107f4b696e7af225f5949',
  x86_64: '36b7ae1f9dec4db1d91953c9c4aa03ed17b25d785d8f87d546dce38bdfc2ee0d'
  })

  def self.patch
    downloader 'https://sourceforge.net/projects/libpng-apng/files/libpng16/1.6.37/libpng-1.6.37-apng.patch.gz'
    abort 'Checksum mismatch :/ try again'.lightred unless Digest::SHA256.hexdigest(File.read('libpng-1.6.37-apng.patch.gz')) == '823bb2d1f09dc7dae4f91ff56d6c22b4b533e912cbd6c64e8762255e411100b6'
    system 'gunzip -c libpng-1.6.37-apng.patch.gz | patch -Np1'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
