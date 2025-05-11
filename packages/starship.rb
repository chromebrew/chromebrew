require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.23.0'
  license 'ISC'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: 'ec58cb85fbb85f3f80c1476fcea49c7c2d882d1c6961f3fd88e2b1b9d00951f0',
     armv7l: 'ec58cb85fbb85f3f80c1476fcea49c7c2d882d1c6961f3fd88e2b1b9d00951f0',
       i686: 'bcbf86c7057809a759a51ff45b711a94a9175a6eb289f6b9b062221491e2d136',
     x86_64: '8d06d2cc67aedd6316ff58ab679fb80cded0d85de1dcd5727df0633d35356d57'
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
