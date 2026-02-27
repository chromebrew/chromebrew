require 'buildsystems/autotools'

class Units < Autotools
  description 'GNU Units converts quantities expressed in various systems of measurement to their equivalents in other systems of measurement.'
  homepage 'https://www.gnu.org/software/units/units.html'
  version '2.26'
  license 'FDL-1.3 and GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/units/units-#{version}.tar.gz"
  source_sha256 '4c43f7a49fe2212ee433d3c0755a0a1935db35497c4a56bf9f68c5f718873c54'
  binary_compression 'tar.zst'

  no_fhs

  binary_sha256({
    aarch64: '8aae0e94c2c316c2262a2b4839df224c652442a75c6fa9813e57d202e12098fa',
     armv7l: '8aae0e94c2c316c2262a2b4839df224c652442a75c6fa9813e57d202e12098fa',
       i686: '6c9194fc3ac34da929729216c1ad3a9c5007ddfb013aaa3be76b1cedeb2236f0',
     x86_64: 'ecc1f41a7148caa0f3c39f667cef5056d58858daec8beaef073c1db0131dbefd'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'readline' => :executable_only

  def self.patch
    system "grep -rlZ '/usr/bin/perl' . | xargs -0 sed -i \'s,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g\'"
  end
end
