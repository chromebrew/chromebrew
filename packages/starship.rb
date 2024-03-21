require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.17.1'
  license 'ISC'
  compatibility 'all'

  source_url({
    aarch64: 'https://github.com/starship/starship/releases/download/v1.17.1/starship-arm-unknown-linux-musleabihf.tar.gz',
     armv7l: 'https://github.com/starship/starship/releases/download/v1.17.1/starship-arm-unknown-linux-musleabihf.tar.gz',
       i686: 'https://github.com/starship/starship/releases/download/v1.17.1/starship-i686-unknown-linux-musl.tar.gz',
     x86_64: 'https://github.com/starship/starship/releases/download/v1.17.1/starship-x86_64-unknown-linux-musl.tar.gz'
  })
  source_sha256({
    aarch64: '29fc0ec401133fb9207e427c4dbae8172f1058085314446389c5b9906f10425f',
     armv7l: '29fc0ec401133fb9207e427c4dbae8172f1058085314446389c5b9906f10425f',
       i686: '950551fecc321e5d7834f489eba06e23456d3e646fe04bf7b1f4d8460d7a13c0',
     x86_64: '4f325e520c4a95116a613b09aeb37f5b99265ca2b9dbf167465db52e836dbcf4'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'starship', "#{CREW_DEST_PREFIX}/bin/starship", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-starship", <<~EOF
      eval "$(starship init bash)"
      eval "$(starship completions bash)"
    EOF
  end
end
