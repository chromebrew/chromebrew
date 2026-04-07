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
    aarch64: '9a92b18e23b93a43885341c93f1e9a5665e4aaf7b6fac9c2846cdc976415afe1',
     armv7l: '9a92b18e23b93a43885341c93f1e9a5665e4aaf7b6fac9c2846cdc976415afe1',
       i686: 'a543ba6a7d8232810f1f17a7e923c36a82bf71b9df8fd6c93f29a18a41d9a798',
     x86_64: '8c20fdbb82a4332d346aa10ea89d5a053f131cff9acb67daa095a0b33c4ce5fd'
  })

  depends_on 'glibc' => :executable
  depends_on 'readline' => :executable

  def self.patch
    system "grep -rlZ '/usr/bin/perl' . | xargs -0 sed -i \'s,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g\'"
  end
end
