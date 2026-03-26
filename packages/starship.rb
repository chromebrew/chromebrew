require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.24.2'
  license 'ISC'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '1df5e6ff76725c72c049484863612a165eb0101fd372b28a3c45e4f38dcbe4ab',
     armv7l: '1df5e6ff76725c72c049484863612a165eb0101fd372b28a3c45e4f38dcbe4ab',
       i686: '8a720ac41d3e27a94d22eda7c3e5f0d2458228c8bcba0e79782a7ed9a0cd72f1',
     x86_64: '00ff3c1f8ffb59b5c15d4b44c076bcca04d92cf0055c86b916248c14f3ae714a'
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
