require 'buildsystems/autotools'

class Mtr < Autotools
  description "mtr combines the functionality of the 'traceroute' and 'ping' programs in a single network diagnostic tool."
  homepage 'https://www.bitwizard.nl/mtr/'
  version '0.96'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/traviscross/mtr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65d74d348d392b112c8edfb200d2f3ab3cbef1f168a8047d808422cc044fe555',
     armv7l: '65d74d348d392b112c8edfb200d2f3ab3cbef1f168a8047d808422cc044fe555',
       i686: '5c48a2da63cb90785ed9a339107733fa5153a1769658f3e372ed21c90328c4f0',
     x86_64: 'f37ff654cceb4241ba4446a9f4a0204a9afc1a4ed5286d8c0c3e0aaf4785b10a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libcap' => :executable
  depends_on 'ncurses' => :executable

  autotools_configure_options '--without-gtk'

  def self.postinstall
    ExitMessage.add <<~EOM

      Execute 'sudo mtr <domain>' to get results.
    EOM
  end
end
