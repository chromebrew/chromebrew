require 'package'

class Frp < Package
  description 'A fast reverse proxy'
  homepage 'https://github.com/fatedier/frp'
  version '0.61.1'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://github.com/fatedier/frp/releases/download/v#{version}/frp_#{version}_linux_arm.tar.gz",
     armv7l: "https://github.com/fatedier/frp/releases/download/v#{version}/frp_#{version}_linux_arm.tar.gz",
     x86_64: "https://github.com/fatedier/frp/releases/download/v#{version}/frp_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '8c7ebb07916e69d959d2a90f80900850c41b6dc1decdb87ccba4bc2f3574f855',
     armv7l: '8c7ebb07916e69d959d2a90f80900850c41b6dc1decdb87ccba4bc2f3574f855',
     x86_64: 'bff260b68ca7b1461182a46c4f34e9709ba32764eed30a15dd94ac97f50a2c40'
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
