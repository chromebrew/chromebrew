require 'package'

class Zoxide < Package
  description 'zoxide is a smarter cd command, inspired by z and autojump.'
  homepage 'https://github.com/ajeetdsouza/zoxide'
  version '0.9.8'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/ajeetdsouza/zoxide/releases/download/v#{version}/zoxide-#{version}-armv7-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/ajeetdsouza/zoxide/releases/download/v#{version}/zoxide-#{version}-armv7-unknown-linux-musleabihf.tar.gz",
     x86_64: "https://github.com/ajeetdsouza/zoxide/releases/download/v#{version}/zoxide-#{version}-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: 'cf8f35f703707a00d6636bbdfcf1636975bdf57162e2749dce0fc0cd09a31e2a',
     armv7l: 'cf8f35f703707a00d6636bbdfcf1636975bdf57162e2749dce0fc0cd09a31e2a',
     x86_64: '4092ee38aa1efde42e4efb2f9c872df5388198aacae7f1a74e5eb5c3cc7f531c'
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
