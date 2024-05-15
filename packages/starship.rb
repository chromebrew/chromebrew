require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.19.0'
  license 'ISC'
  compatibility 'all'

  source_url({
    aarch64: 'https://github.com/starship/starship/releases/download/v1.19.0/starship-arm-unknown-linux-musleabihf.tar.gz',
     armv7l: 'https://github.com/starship/starship/releases/download/v1.19.0/starship-arm-unknown-linux-musleabihf.tar.gz',
       i686: 'https://github.com/starship/starship/releases/download/v1.19.0/starship-i686-unknown-linux-musl.tar.gz',
     x86_64: 'https://github.com/starship/starship/releases/download/v1.19.0/starship-x86_64-unknown-linux-musl.tar.gz'
  })
  source_sha256({
    aarch64: '9c30af40245b2d854c4bb1e8c620a4e9cdf2e3d097b6e3f8abb943ef6163444c',
     armv7l: '9c30af40245b2d854c4bb1e8c620a4e9cdf2e3d097b6e3f8abb943ef6163444c',
       i686: '0378fe8c06be6ee2c763dcabd429ffa760d67b257efed31d47c55ee721102fde',
     x86_64: 'a4283306d7d89e215208e787a851892b4933cddf8624366734d3614f816a675a'
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
