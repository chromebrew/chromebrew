require 'package'

class Wishlist < Package
  description 'The SSH directory - a single entrypoint for multiple SSH endpoints.'
  homepage 'https://charm.sh'
  version '0.15.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/charmbracelet/wishlist/releases/download/v#{version}/wishlist_#{version}_linux_armv7.tar.gz",
     armv7l: "https://github.com/charmbracelet/wishlist/releases/download/v#{version}/wishlist_#{version}_linux_armv7.tar.gz",
       i686: "https://github.com/charmbracelet/wishlist/releases/download/v#{version}/wishlist_#{version}_linux_i386.tar.gz",
     x86_64: "https://github.com/charmbracelet/wishlist/releases/download/v#{version}/wishlist_#{version}_linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '94fb20343202ecea88d40ec50f7fe6dbb00e97a937324506913c2abb005c444e',
     armv7l: '94fb20343202ecea88d40ec50f7fe6dbb00e97a937324506913c2abb005c444e',
       i686: 'e790a33bed696f3633646920951b80ae4e9ed0198e1d137a84f98750733e2ffe',
     x86_64: '09b9bf4623b77b115e85403440122128a15edfc3021d3fac9f2c0ab01fb32555'
  })

  print_source_bashrc

  def self.build
    File.write 'bash_completion', <<~BASHD_EOF
      # wishlist bash completion
      source #{CREW_PREFIX}/share/wishlist/completions/wishlist.bash
    BASHD_EOF
  end

  def self.install
    FileUtils.install 'wishlist', "#{CREW_DEST_PREFIX}/bin/wishlist", mode: 0o755
    FileUtils.install 'bash_completion', "#{CREW_DEST_PREFIX}/etc/bash.d/wishlist", mode: 0o644
    FileUtils.install Dir['completions/*'], "#{CREW_DEST_PREFIX}/share/wishlist/completions", mode: 0o644
    FileUtils.install 'manpages/wishlist.1.gz', "#{CREW_DEST_MAN_PREFIX}/man1/wishlist.1.gz", mode: 0o644
  end
end
