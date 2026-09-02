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
    aarch64: 'c3cb80317d20af10c73e660789f61b5ff183338d1ef05ef52a4895e92566b459',
     armv7l: 'c3cb80317d20af10c73e660789f61b5ff183338d1ef05ef52a4895e92566b459',
       i686: '50057d6fa01e19ff60da7c68de9ed5d1f60dfe9ad7d73f22daf45d68bb172ad1',
     x86_64: '3193c16555554d63bffe63957b6add1ab3f689bb8d5eb57f22533068fceb5605'
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
