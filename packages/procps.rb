require 'buildsystems/autotools'

class Procps < Autotools
  description 'procps is a set of command line and full-screen utilities that provide information out of the pseudo-filesystem most commonly located at /proc.'
  homepage 'https://gitlab.com/procps-ng/procps'
  version '4.0.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/procps-ng/procps.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3bafa254aef067d1ee187ac57ca08351867ad2b29b8f0cb8dcedab4f3e6067c',
     armv7l: 'f3bafa254aef067d1ee187ac57ca08351867ad2b29b8f0cb8dcedab4f3e6067c',
       i686: '50057d6fa01e19ff60da7c68de9ed5d1f60dfe9ad7d73f22daf45d68bb172ad1',
     x86_64: 'bb6bf2cdaea0f3d58aca1319a419cda04c28264733d9b24c33994b73ead5eaec'
  })

  depends_on 'glibc' => :library
  depends_on 'ncurses' => :executable

  conflicts_ok # Conflicts with uutils_coreutils.

  def self.patch
    patches = [
      # Fix compatibility with older glibc.
      ['https://gitlab.com/procps-ng/procps/-/commit/c0caea27796315d4628a0f60e24ff572add9ed07.diff', '24b6928e87f388f633b51b98025c15ca6cd40c4cd388278cbb98bd06c64be719']
    ]
    ConvenienceFunctions.patch(patches) if version == '4.0.7'
  end

  autotools_configure_options ('--disable-pidwait' if ARCH == 'i686').to_s
end
