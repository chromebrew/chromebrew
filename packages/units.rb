require 'buildsystems/autotools'

class Units < Autotools
  description 'GNU Units converts quantities expressed in various systems of measurement to their equivalents in other systems of measurement.'
  homepage 'https://www.gnu.org/software/units/units.html'
  version '2.27'
  license 'FDL-1.3 and GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/units/units-#{version}.tar.gz"
  source_sha256 'e1bbdb09672e7c08eee986749e7a1629eb84a6bdf41f5a2a79d6804444abbe10'
  binary_compression 'tar.zst'

  no_fhs

  binary_sha256({
    aarch64: '8aae0e94c2c316c2262a2b4839df224c652442a75c6fa9813e57d202e12098fa',
     armv7l: '8aae0e94c2c316c2262a2b4839df224c652442a75c6fa9813e57d202e12098fa',
       i686: '6c9194fc3ac34da929729216c1ad3a9c5007ddfb013aaa3be76b1cedeb2236f0',
     x86_64: 'ecc1f41a7148caa0f3c39f667cef5056d58858daec8beaef073c1db0131dbefd'
  })

  depends_on 'glibc' => :executable
  depends_on 'readline' => :executable

  def self.patch
    system "grep -rlZ '/usr/bin/perl' . | xargs -0 sed -i \'s,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g\'"
  end
end
