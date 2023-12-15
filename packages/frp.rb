require 'package'

class Frp < Package
  description 'A fast reverse proxy'
  homepage 'https://github.com/fatedier/frp'
  version '0.53.0'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/fatedier/frp/releases/download/v0.53.0/frp_0.53.0_linux_arm.tar.gz',
     armv7l: 'https://github.com/fatedier/frp/releases/download/v0.53.0/frp_0.53.0_linux_arm.tar.gz',
     x86_64: 'https://github.com/fatedier/frp/releases/download/v0.53.0/frp_0.53.0_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'e33075389b77f94a816ac45bf1d0ce2b540fd98dafac9828602625088967762f',
     armv7l: 'e33075389b77f94a816ac45bf1d0ce2b540fd98dafac9828602625088967762f',
     x86_64: '662d62af7744b9b639b3473bbdd2c4c70dfa5ac5fe1d058d13ce3cc7ea059500'
  })

  no_compile_needed

  def self.build
    File.write 'frpc.sh', <<~EOF
      #!/bin/bash
      #{CREW_PREFIX}/share/frp/frpc -c #{CREW_PREFIX}/share/frp/frpc.toml "$@"
    EOF
    File.write 'frps.sh', <<~EOF
      #!/bin/bash
      #{CREW_PREFIX}/share/frp/frps -c #{CREW_PREFIX}/share/frp/frps.toml "$@"
    EOF
  end

  def self.install
    FileUtils.install 'frpc.sh', "#{CREW_DEST_PREFIX}/bin/frpc", mode: 0o755
    FileUtils.install 'frps.sh', "#{CREW_DEST_PREFIX}/bin/frps", mode: 0o755
    FileUtils.rm Dir['*.sh']
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/frp"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/frp"
  end

  def self.postinstall
    puts "\nType 'frps &' to start the server and run in the background.".lightblue
    puts "Type 'frpc &' to start the client on another machine.".lightblue
    puts "For more information, see https://github.com/fatedier/frp.\n".lightblue
  end
end
