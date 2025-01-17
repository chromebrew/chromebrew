require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.22.1'
  license 'ISC'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '41dd34b405eca3cd9258879c5f43e1f34461e1c9ab0a5308d6df33024e6a853a',
     armv7l: '41dd34b405eca3cd9258879c5f43e1f34461e1c9ab0a5308d6df33024e6a853a',
       i686: '71668f4ee6bbf04c449e820ca06b2afb529d87458ff7bf1b1bab0cd5bb4ad4b8',
     x86_64: '62c91b5ecc7f8c8c6ea7ffea42a98bd2e6a2d29daf61562fac04daece18a6461'
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
