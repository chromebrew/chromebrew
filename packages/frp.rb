require 'package'

class Frp < Package
  description 'A fast reverse proxy'
  homepage 'https://github.com/fatedier/frp'
  version '0.61.2'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/fatedier/frp/releases/download/v#{version}/frp_#{version}_linux_arm.tar.gz",
     armv7l: "https://github.com/fatedier/frp/releases/download/v#{version}/frp_#{version}_linux_arm.tar.gz",
     x86_64: "https://github.com/fatedier/frp/releases/download/v#{version}/frp_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '8d9e484531bd2e2f25bb7a0466da67d0e717e110e587b12f9b02487f38797d92',
     armv7l: '8d9e484531bd2e2f25bb7a0466da67d0e717e110e587b12f9b02487f38797d92',
     x86_64: '4738edbd4bf88db5fe0ccee946d63da3b498c9cc50b0c7317d017fe7d28a05ea'
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
    ExitMessage.add <<~EOM

      Type 'frps &' to start the server and run in the background.
      Type 'frpc &' to start the client on another machine.
      For more information, see https://github.com/fatedier/frp.
    EOM
  end
end
