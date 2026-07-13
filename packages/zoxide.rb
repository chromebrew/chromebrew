require 'package'

class Zoxide < Package
  description 'zoxide is a smarter cd command, inspired by z and autojump.'
  homepage 'https://github.com/ajeetdsouza/zoxide'
  version '0.10.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/ajeetdsouza/zoxide/releases/download/v#{version}/zoxide-#{version}-armv7-unknown-linux-musleabihf.tar.gz",
     armv7l: "https://github.com/ajeetdsouza/zoxide/releases/download/v#{version}/zoxide-#{version}-armv7-unknown-linux-musleabihf.tar.gz",
     x86_64: "https://github.com/ajeetdsouza/zoxide/releases/download/v#{version}/zoxide-#{version}-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '0b3035b2f5ee25ea8681948b6bfd8308bdf596d2b720b26e32e7d35cedfa08f6',
     armv7l: '0b3035b2f5ee25ea8681948b6bfd8308bdf596d2b720b26e32e7d35cedfa08f6',
     x86_64: '2d93385b99f3e82cf2701609a1bffcad863fbeb75aa3fe7eb6be4d29be68b1ae'
  })

  depends_on 'fzf' => :executable

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
