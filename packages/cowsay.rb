require 'package'

class Cowsay < Package
  description 'cowsay is a program that generates ASCII pictures of a cow with a message.'
  homepage 'https://github.com/tnalpgge/rank-amateur-cowsay/'
  version '3.04-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tnalpgge/rank-amateur-cowsay/archive/cowsay-3.04.tar.gz'
  source_sha256 'd8b871332cfc1f0b6c16832ecca413ca0ac14d58626491a6733829e3d655878b'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cowsay/3.04-1_armv7l/cowsay-3.04-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cowsay/3.04-1_armv7l/cowsay-3.04-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cowsay/3.04-1_i686/cowsay-3.04-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cowsay/3.04-1_x86_64/cowsay-3.04-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3cd6ecc3ce8521dd6e9d598bf72437cb5ab6982ef9d0a8eaa2d991cf57ed7bac',
     armv7l: '3cd6ecc3ce8521dd6e9d598bf72437cb5ab6982ef9d0a8eaa2d991cf57ed7bac',
       i686: '1be94667059deddba4a0ab9b7fdfd3da5c6cd3b5ddc0e26a8b9e4d3ee392e252',
     x86_64: 'fd12dde923ae983c6832731ce3091ce1149b0a8df87a1f8df20c2c3f77bec6dd'
  })

  def self.install
    system "sh install.sh #{CREW_DEST_PREFIX}"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @cowsayenv = <<~COWSAYEOF
      # Set COWPATH for cowsay
      export COWPATH=#{CREW_PREFIX}/share/cows
    COWSAYEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/cowsay", @cowsayenv)
  end
end
