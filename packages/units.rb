require 'buildsystems/autotools'

class Units < Autotools
  description 'GNU Units converts quantities expressed in various systems of measurement to their equivalents in other systems of measurement.'
  homepage 'https://www.gnu.org/software/units/units.html'
  version '2.25'
  license 'FDL-1.3 and GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/units/units-#{version}.tar.gz"
  source_sha256 '36edf43ac00b4d6304baea91387e65ab05118bf65c921f73d3b08828e5a6ec0b'
  binary_compression 'tar.zst'

  no_fhs

  binary_sha256({
    aarch64: 'b797a9eb026d519d6965bde20d670af5fdfe19b3fe7910cbb379ce660c113333',
     armv7l: 'b797a9eb026d519d6965bde20d670af5fdfe19b3fe7910cbb379ce660c113333',
       i686: '34261a4689a15a0828ab643ab91fda0c929b5338d48de76afc35a9ec0c6c30b8',
     x86_64: 'd6f9734271ce73659f4daad53fb3d168d8dcd00133b9b0b2af39f3d7c175b813'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'readline' => :executable_only

  def self.patch
    system "grep -rlZ '/usr/bin/perl' . | xargs -0 sed -i \'s,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g\'"
  end
end
