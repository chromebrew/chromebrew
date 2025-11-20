require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.24.1'
  license 'ISC'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '639503f751231eea5a51a2e6feaa24b6ee3c56b8a92457bd4337a2b778247d3e',
     armv7l: '639503f751231eea5a51a2e6feaa24b6ee3c56b8a92457bd4337a2b778247d3e',
       i686: '866d09eba481794fd5afaf43aaec4515f03f635f48074b0af7b9a913857a9bd6',
     x86_64: '44a729c34aea5b0451fba49108cdc5ef6b1ae68db65e7623cc244a52efcd23d1'
  })

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.install
    FileUtils.install 'starship', "#{CREW_DEST_PREFIX}/bin/starship", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-starship", <<~EOF
      eval "$(starship init bash)"
      eval "$(starship completions bash)"
    EOF
  end
end
