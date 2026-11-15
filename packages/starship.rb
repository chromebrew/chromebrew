require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.27.0'
  license 'ISC'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '33531a104304e8f36e1f78657039246ebb730e4c53a7ccdf8c94c0e3630bf6b4',
     armv7l: '33531a104304e8f36e1f78657039246ebb730e4c53a7ccdf8c94c0e3630bf6b4',
       i686: '3ccbd2aca8e8189f13272e71d51549001694bceb82191b28d009efe1ef597f7f',
     x86_64: '10c8eb4cb3b761d9bf59ea828444c2dab36c900b7d69a69e08814b286969df89'
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
