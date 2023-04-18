require 'package'

class Aribb24 < Package
  description 'aribb24 is a basic implementation of the ARIB STD-B24 public standard.'
  homepage 'https://github.com/nkoriyama/aribb24/'
  version '1.0.3'
  compatibility 'all'
  license 'LGPL-3'
  source_url 'https://github.com/nkoriyama/aribb24.git'
  git_hashtag "v#{@version}"

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/aribb24-1.0.3-chromeos-armv7l.tpxz',
      armv7l: 'file:///usr/local/tmp/packages/aribb24-1.0.3-chromeos-armv7l.tpxz',
        i686: 'file:///usr/local/tmp/packages/aribb24-1.0.3-chromeos-i686.tpxz',
      x86_64: 'file:///usr/local/tmp/packages/aribb24-1.0.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c1a2d6f4596e1d1e1e622c28b5224e114d68ba85272a1506f5e420aa703932a6',
      armv7l: 'c1a2d6f4596e1d1e1e622c28b5224e114d68ba85272a1506f5e420aa703932a6',
        i686: '3d35337928479ab6f9085deea67ac7dd788c07ebdb9ed0e00c0731b569931ed4',
      x86_64: '44d684b99a0c067691d16c715daea8afe40bc4c6611da33b87d31084eab8e55e'
  })

  depends_on 'libpng'

  def self.build
    system './bootstrap'
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
