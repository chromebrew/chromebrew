require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.26.0'
  license 'ISC'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: 'c7bd93b1cfb87dd4e531d100b4f87cb77eee9eb2982d9428940bc006db4ab689',
     armv7l: 'c7bd93b1cfb87dd4e531d100b4f87cb77eee9eb2982d9428940bc006db4ab689',
       i686: '6a19cd68dcfb945bcc60fbe1931b21fdae5277dcb761cba7582beccdcd5468be',
     x86_64: 'b7c232b0e8249d8e55a40beb79c5c43a7d370f3f9408bd215deb0170daeaadf3'
  })

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.build
    File.write '10-starship', <<~EOF
      eval "$(starship init bash)"
      eval "$(starship completions bash)"
    EOF
  end

  def self.install
    FileUtils.install 'starship', "#{CREW_DEST_PREFIX}/bin/starship", mode: 0o755
    FileUtils.install '10-starship', "#{CREW_DEST_PREFIX}/etc/env.d/10-starship", mode: 0o644
  end
end
