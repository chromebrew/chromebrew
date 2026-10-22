require 'package'

class Rqlite < Package
  description 'The lightweight, user-friendly, distributed relational database built on SQLite.'
  homepage 'https://rqlite.io/'
  version '10.6.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url({
    aarch64: "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-arm.tar.gz",
     armv7l: "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-arm.tar.gz",
     x86_64: "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: '820207277315ed1366a9f510582c747b8170dd15f83ea7f55cbb58a7e72b758b',
     armv7l: '820207277315ed1366a9f510582c747b8170dd15f83ea7f55cbb58a7e72b758b',
     x86_64: '756137bc0a1047ccf1e4802f2c8dd2710c3b8433a3244cf43c2e583af8f5e289'
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
