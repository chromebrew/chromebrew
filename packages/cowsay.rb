require 'package'

class Cowsay < Package
  description 'cowsay is a program that generates ASCII pictures of a cow with a message.'
  homepage 'https://github.com/tnalpgge/rank-amateur-cowsay/'
  version '3.04'
  source_url 'https://github.com/tnalpgge/rank-amateur-cowsay/archive/cowsay-3.04.tar.gz'
  source_sha256 'd8b871332cfc1f0b6c16832ecca413ca0ac14d58626491a6733829e3d655878b'

  def self.install
    system "sh install.sh #{CREW_DEST_PREFIX}"
  end
end
