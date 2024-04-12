require 'package'

class Zoxide < Package
  description 'zoxide is a smarter cd command, inspired by z and autojump.'
  homepage 'https://github.com/ajeetdsouza/zoxide'
  version '0.9.4'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.4/zoxide-0.9.4-armv7-unknown-linux-musleabihf.tar.gz',
     armv7l: 'https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.4/zoxide-0.9.4-armv7-unknown-linux-musleabihf.tar.gz',
     x86_64: 'https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.4/zoxide-0.9.4-x86_64-unknown-linux-musl.tar.gz'
  })
  source_sha256({
    aarch64: 'ebdd745313dd8d9b9aa36b408eea1720ec2caf310262f15c74c47b37e41702ab',
     armv7l: 'ebdd745313dd8d9b9aa36b408eea1720ec2caf310262f15c74c47b37e41702ab',
     x86_64: 'fbc22c115a252f9a5c73301e35ed695810d020126b126c3d0e47f0b31f2255a0'
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
