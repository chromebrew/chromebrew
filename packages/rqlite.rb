require 'package'

class Rqlite < Package
  description 'The lightweight, user-friendly, distributed relational database built on SQLite.'
  homepage 'https://rqlite.io/'
  version '10.0.5'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url({
    aarch64: "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-arm.tar.gz",
     armv7l: "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-arm.tar.gz",
     x86_64: "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: '5e3bff1c9b94fe22571b219e0defd77f0f08c7fe6e89751040769fa65f2e7946',
     armv7l: '5e3bff1c9b94fe22571b219e0defd77f0f08c7fe6e89751040769fa65f2e7946',
     x86_64: '63e5bb4b163474dd2fb4121f7ccb7f4030ae7e507f8e81edb9733f59b2362e1c'
  })

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
    if File.exist?("#{CREW_PREFIX}/opt/glibc-libs/ld-linux-armhf.so.3") && !File.exist?("#{CREW_LIB_PREFIX}/ld-linux.so.3")
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.ln_s "#{CREW_PREFIX}/opt/glibc-libs/ld-linux-armhf.so.3", "#{CREW_DEST_LIB_PREFIX}/ld-linux.so.3"
    end
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
