require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.21.1'
  license 'ISC'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: 'ddb4a4c65388aa14d421f22f6b10b386ea7183ee5d124835fbf529a5556f4816',
     armv7l: 'ddb4a4c65388aa14d421f22f6b10b386ea7183ee5d124835fbf529a5556f4816',
       i686: 'ad662c46cc8dc6220c01bc88549192fc724fb17e59027c9e5bbfcde275cde89f',
     x86_64: '744e21eb2e61b85b0c11378520ebb9e94218de965bca5b8c2266f6c3e23ff5be'
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
