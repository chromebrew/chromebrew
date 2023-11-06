require 'package'

class Zoxide < Package
  description 'zoxide is a smarter cd command, inspired by z and autojump.'
  homepage 'https://github.com/ajeetdsouza/zoxide'
  version '0.9.2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.2/zoxide-0.9.2-armv7-unknown-linux-musleabihf.tar.gz',
     armv7l: 'https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.2/zoxide-0.9.2-armv7-unknown-linux-musleabihf.tar.gz',
     x86_64: 'https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.2/zoxide-0.9.2-x86_64-unknown-linux-musl.tar.gz'
  })
  source_sha256({
    aarch64: '050e6e8e14479b916e9715ccf76f66ab308cef197d9745bca4b6dfbeb70cea39',
     armv7l: '050e6e8e14479b916e9715ccf76f66ab308cef197d9745bca4b6dfbeb70cea39',
     x86_64: 'd5598a321eb9ba0bf4c8c54f991fe4be69a65a6a81094c586539225c47ef2c7b'
  })

  depends_on 'fzf'

  no_compile_needed
  reload_source

  def self.build
    File.write 'zoxide.bash', <<~EOF
      #!/bin/bash
      source #{CREW_PREFIX}/share/completions/zoxide.bash
    EOF
    File.write 'zoxide.init', <<~EOF
      #!/bin/bash
      eval "$(zoxide init bash)"
    EOF
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.install 'zoxide.bash', "#{CREW_DEST_PREFIX}/etc/env.d/zoxide.bash", mode: 0o644
    FileUtils.install 'zoxide.init', "#{CREW_DEST_PREFIX}/etc/env.d/zoxide.init", mode: 0o644
    FileUtils.install 'zoxide', "#{CREW_DEST_PREFIX}/bin/zoxide", mode: 0o755
    FileUtils.mv 'completions', "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'man/man1', CREW_DEST_MAN_PREFIX.to_s
  end
end
