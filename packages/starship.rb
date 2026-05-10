require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.25.1'
  license 'ISC'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '1aa14d0142fe6da17b7a50ef4641b0512d144f7b37d9efce883fe20d808165cf',
     armv7l: '1aa14d0142fe6da17b7a50ef4641b0512d144f7b37d9efce883fe20d808165cf',
       i686: '2296c004789975ddb3c40e18ad2f565fd9719b1ddaf3b630b4ecfe83445e2625',
     x86_64: 'c6ddd3ecb9c0071a2ad38d98cee748160066b7c4f197421268058f4a5d6f8504'
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
