require 'package'

class Zoxide < Package
  description 'zoxide is a smarter cd command, inspired by z and autojump.'
  homepage 'https://github.com/ajeetdsouza/zoxide'
  version '0.9.6'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://github.com/ajeetdsouza/zoxide/releases/download/v#{version}/zoxide-#{version}-armv7-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/ajeetdsouza/zoxide/releases/download/v#{version}/zoxide-#{version}-armv7-unknown-linux-musleabihf.tar.gz",
     x86_64: "https://github.com/ajeetdsouza/zoxide/releases/download/v#{version}/zoxide-#{version}-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '9cf71b83d4254ed1209271bd636d7078eb76d681c91085ef4d763ab933d9a33e',
     armv7l: '9cf71b83d4254ed1209271bd636d7078eb76d681c91085ef4d763ab933d9a33e',
     x86_64: 'eaa18f8aca1f02e1a132a9eac21b630918f96fa1cc7486ab87e7053dad37b004'
  })

  depends_on 'fzf'

  no_compile_needed
  print_source_bashrc

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
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.install 'zoxide.bash', "#{CREW_DEST_PREFIX}/etc/env.d/zoxide.bash", mode: 0o644
    FileUtils.install 'zoxide.init', "#{CREW_DEST_PREFIX}/etc/env.d/zoxide.init", mode: 0o644
    FileUtils.install 'zoxide', "#{CREW_DEST_PREFIX}/bin/zoxide", mode: 0o755
    FileUtils.mv 'completions', "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'man/man1', CREW_DEST_MAN_PREFIX
  end
end
