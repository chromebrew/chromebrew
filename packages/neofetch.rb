require 'package'

class Neofetch < Package
  description 'A fast, highly customizable system info script'
  homepage 'https://github.com/dylanaraps/neofetch'
  version '6.0.0'
  compatibility 'all'
  source_url 'https://github.com/dylanaraps/neofetch/archive/6.0.0.tar.gz'
  source_sha256 '264a7689561bb498f97f10231959bdd8f7c873671bac2ffb660de9a5863b1c76'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/neofetch-6.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/neofetch-6.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/neofetch-6.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/neofetch-6.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4913ca13f21e57c9d7410a4bb1265efd43d7c4aedda8429ad5a5f6fe7b6f8bc2',
     armv7l: '4913ca13f21e57c9d7410a4bb1265efd43d7c4aedda8429ad5a5f6fe7b6f8bc2',
       i686: '4865152e558fc7b45c945fb54a65486f80afd80efff80fcee4922b3962496d2e',
     x86_64: '4c8f2e53031f299c5933d5442d7caafc6647bfd4eaa3f97434d93c9387c3a757',
  })

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", 'install'
  end
end
