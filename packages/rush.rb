require 'buildsystems/autotools'

class Rush < Autotools
  description 'GNU Rush is a Restricted User Shell.'
  homepage 'https://www.gnu.org/software/rush/'
  version '2.4'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/rush/rush-#{version}.tar.xz"
  source_sha256 'fa95af9d2c7b635581841cc27a1d27af611f60dd962113a93d23a8874aa060f4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '683a833494ae48caaf8b13203d3da6b059ebc93cb1884cc7cd14a7322629f956',
     armv7l: '683a833494ae48caaf8b13203d3da6b059ebc93cb1884cc7cd14a7322629f956',
       i686: 'b5fefc1bb15a05299c83f8e02d7c0388d5d3c14de575f34c252ed12e44ff9a34',
     x86_64: 'd6c610c443b41d2a726edf74afbb628ecc9a4248cdf2405f68d00c0091bc44f9'
  })

  depends_on 'glibc' => :executable_only

  def self.patch
    # The aclocal version is hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp.gsub(/\.\d+$/, '')
    system "sed -i 's,1.16,#{aclocal_version},g' configure"
  end

  # Tests fail with transform and interactive.
  # run_tests
end
