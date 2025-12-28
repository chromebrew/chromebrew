require 'package'

class Rqlite < Package
  description 'The lightweight, user-friendly, distributed relational database built on SQLite.'
  homepage 'https://rqlite.io/'
  version '9.3.6'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url({
    aarch64: "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-arm.tar.gz",
     armv7l: "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-arm.tar.gz",
     x86_64: "https://github.com/rqlite/rqlite/releases/download/v#{version}/rqlite-v#{version}-linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'f2f4d7c1c56a02356c8aa3206e936070858c18cb0c13a9053de2b25150ecc1d4',
     armv7l: 'f2f4d7c1c56a02356c8aa3206e936070858c18cb0c13a9053de2b25150ecc1d4',
     x86_64: '0454da5cf81aab429a4d9766a982e5dd9b35f36d301f29905e7d372e17f3559c'
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
