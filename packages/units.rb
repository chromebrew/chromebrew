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
    aarch64: 'adbe9a062ca462fe4d0496cd00dac2f4ae216a3a3985e9fef0a791aeac27126d',
     armv7l: 'adbe9a062ca462fe4d0496cd00dac2f4ae216a3a3985e9fef0a791aeac27126d',
       i686: '9cb31db0679ec2bd7f7428279ebd22824ce1a16bae8114466e98d0e168f447d5',
     x86_64: 'ab4f6ba7b24e47e375f22553251fee588718e7b4f14c32dd0d425b2be1084fa8'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'readline' => :executable_only

  def self.patch
    system "grep -rlZ '/usr/bin/perl' . | xargs -0 sed -i \'s,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g\'"
  end
end
