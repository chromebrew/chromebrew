require 'package'

class Starship < Package
  description 'Cross-shell prompt for astronauts'
  homepage 'https://starship.rs'
  version '1.25.0'
  license 'ISC'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/starship/starship/releases/download/v#{version}/starship-arm-unknown-linux-musleabihf.tar.gz",
       i686: "https://github.com/starship/starship/releases/download/v#{version}/starship-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/starship/starship/releases/download/v#{version}/starship-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: 'edc09c45f72abf7ae7dd379d7b6ef227e085585921adce6ace66d5db869f2b48',
     armv7l: 'edc09c45f72abf7ae7dd379d7b6ef227e085585921adce6ace66d5db869f2b48',
       i686: '93568c9428a52c41c9784b16bbd97c915b1a48d8851fd3725363c6436ec171cd',
     x86_64: '0169f187e927a0ee9abf41bb80e316717fea6e37e404267bca5134c6ea10c0ed'
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
