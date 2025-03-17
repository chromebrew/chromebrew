require 'package'

class Rqlite < Package
  description 'The lightweight, user-friendly, distributed relational database built on SQLite.'
  homepage 'https://rqlite.io/'
  version '8.36.14'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-amd64.tar.gz"
  source_sha256 '16188b5d045f6c1ecd5be2c894b6f25143b7d099f5d32d75a1c345812f3b85b5'

  depends_on 'psmisc'

  no_shrink
  no_compile_needed
  print_source_bashrc

  def self.build
    File.write 'rqlited.sh', <<~EOF
      #{CREW_PREFIX}/bin/startrqlited
    EOF
    File.write 'startrqlited', <<~EOF
      #!/bin/bash
      #{CREW_PREFIX}/bin/rqlited #{HOME}/.rqlite &
    EOF
    File.write 'stoprqlited', <<~EOF
      #!/bin/bash
      killall rqlited
    EOF
  end

  def self.install
    FileUtils.install %w[rqbench rqlite rqlited startrqlited stoprqlited], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install 'rqlited.sh', "#{CREW_DEST_PREFIX}/etc/bash.d/10-rqlited"
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Run 'startrqlited' to start the rqlite daemon.
      Run 'stoprqlited' to stop the rqlite daemon.
      Run 'rqlite' to start the cli.

    EOM
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.rqlite")
  end
end
