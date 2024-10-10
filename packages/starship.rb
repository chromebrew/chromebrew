require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.20.0'
  license 'ISC'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '833abffca4c417b1118723c3fb07966da408affdccd95628a14c71af61545b53',
     armv7l: '833abffca4c417b1118723c3fb07966da408affdccd95628a14c71af61545b53',
       i686: 'bc77a9335800aaf966cbe29896dda9ff1de9d9034efecd5e0d735297eafed4a4',
     x86_64: '8b674659524fc6147f1b9857ed0135db277378f5dec2a98763502ce1471fa886'
  })

  no_compile_needed
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
