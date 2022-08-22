require 'package'

class Wishlist < Package
  description 'The SSH directory - a single entrypoint for multiple SSH endpoints.'
  homepage 'https://charm.sh'
  version '0.5.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/charmbracelet/wishlist/releases/download/v0.5.0/wishlist_0.5.0_linux_armv7.tar.gz',
     armv7l: 'https://github.com/charmbracelet/wishlist/releases/download/v0.5.0/wishlist_0.5.0_linux_armv7.tar.gz',
       i686: 'https://github.com/charmbracelet/wishlist/releases/download/v0.5.0/wishlist_0.5.0_linux_i386.tar.gz',
     x86_64: 'https://github.com/charmbracelet/wishlist/releases/download/v0.5.0/wishlist_0.5.0_linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: 'fd713821913fc13c52dd4d5f9034669b2a65094aaa36fad8571afb7cdf80c8a3',
     armv7l: 'fd713821913fc13c52dd4d5f9034669b2a65094aaa36fad8571afb7cdf80c8a3',
       i686: '39d26bdac4bfb92014f79a03af7c213f2b6ec2b9cdb82d53b7ce99af6cc52f52',
     x86_64: 'b1834e196974287f7050bec38d7a0973d093e6260cab79cd942d605b955187a3'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/wishlist"
    FileUtils.mv 'completions', "#{CREW_DEST_PREFIX}/share/wishlist"
    FileUtils.mv 'manpages/wishlist.1.gz', "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.install 'wishlist', "#{CREW_DEST_PREFIX}/bin/wishlist", mode: 0o755
    bash_completion = <<~BASHD_EOF
      # wishlist bash completion
      source #{CREW_PREFIX}/share/wishlist/completions/wishlist.bash
    BASHD_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/wishlist", bash_completion)
  end
end
