require 'package'

class Vuls < Package
  description 'Agent-less vulnerability scanner'
  homepage 'https://vuls.io/'
  version ARCH.eql?('x86_64') ? '0.43.0' : '0.29.0'
  license 'GPL-3.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/future-architect/vuls/releases/download/v#{version}/future-vuls_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/future-architect/vuls/releases/download/v#{version}/future-vuls_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/future-architect/vuls/releases/download/v#{version}/future-vuls_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/future-architect/vuls/releases/download/v#{version}/future-vuls_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '373dfbee23d20041eca55f635f4599c917ffaf0c863130c975b9ad94a545c618',
     armv7l: '373dfbee23d20041eca55f635f4599c917ffaf0c863130c975b9ad94a545c618',
       i686: '56f5823029ed304d95c226f39542e9ded0f757603cb56289756d8536fe91d250',
     x86_64: 'aa3dbf675fe521e6c92c88c32c814f559d45fc510bf686fd8f7854421d82175e'
  })
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vuls/0.29.0_armv7l/vuls-0.29.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vuls/0.29.0_armv7l/vuls-0.29.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vuls/0.29.0_i686/vuls-0.29.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vuls/0.43.0_x86_64/vuls-0.43.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1e6545e3aeb2ac7121b94a217e5335095cb7b110e802682b02729ca99afaf4e6',
     armv7l: '1e6545e3aeb2ac7121b94a217e5335095cb7b110e802682b02729ca99afaf4e6',
       i686: '6d79426edd9a6a153760abe48d365d9bb53199c24825d88a8635deacfa3a88b9',
     x86_64: 'aa3dbf675fe521e6c92c88c32c814f559d45fc510bf686fd8f7854421d82175e'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build
  depends_on 'revive' => :build
  depends_on 'sqlite' => :library

  no_shrink
  print_source_bashrc

  def self.build
    File.write '10-vuls.bash', <<~EOF
      #!/bin/bash
      eval "$(vuls completion bash)"
    EOF
    File.write 'config.toml', <<~EOF
      [servers]

      [servers.localhost]
      host = "localhost"
      port = "local"
    EOF
    File.write 'build.sh', <<~EOF
      #!/bin/bash
      git clone https://github.com/vulsio/go-cve-dictionary.git
      cd go-cve-dictionary
      go build
      cd ..
      git clone https://github.com/vulsio/goval-dictionary.git
      cd goval-dictionary
      go build
      cd ..
      git clone https://github.com/vulsio/gost.git
      cd gost
      go build
      cd ..
      git clone https://github.com/vulsio/go-exploitdb.git
      cd go-exploitdb
      go build
      cd ..
      git clone https://github.com/vulsio/go-msfdb.git
      cd go-msfdb
      go build
      cd ..
      git clone https://github.com/vulsio/go-kev.git
      cd go-kev
      go build
      cd ..
      git clone https://github.com/vulsio/go-cti.git
      cd go-cti
      go build
      cd ..
      git clone https://github.com/future-architect/vuls.git
      cd vuls
      make build
    EOF
    FileUtils.chmod 0o755, 'build.sh'
    system './build.sh'
  end

  def self.install
    FileUtils.install 'go-cve-dictionary/go-cve-dictionary', "#{CREW_DEST_PREFIX}/bin/go-cve-dictionary", mode: 0o755
    FileUtils.install 'goval-dictionary/goval-dictionary', "#{CREW_DEST_PREFIX}/bin/goval-dictionary", mode: 0o755
    FileUtils.install 'gost/gost', "#{CREW_DEST_PREFIX}/bin/gost", mode: 0o755
    FileUtils.install 'go-exploitdb/go-exploitdb', "#{CREW_DEST_PREFIX}/bin/go-exploitdb", mode: 0o755
    FileUtils.install 'go-msfdb/go-msfdb', "#{CREW_DEST_PREFIX}/bin/go-msfdb", mode: 0o755
    FileUtils.install 'go-kev/go-kev', "#{CREW_DEST_PREFIX}/bin/go-key", mode: 0o755
    FileUtils.install 'go-cti/go-cti', "#{CREW_DEST_PREFIX}/bin/go-cti", mode: 0o755
    FileUtils.install 'vuls/vuls', "#{CREW_DEST_PREFIX}/bin/vuls", mode: 0o755
    FileUtils.install 'future-vuls', "#{CREW_DEST_PREFIX}/bin/future-vuls", mode: 0o755
    FileUtils.install '10-vuls.bash', "#{CREW_DEST_PREFIX}/etc/env.d/10-vuls.bash", mode: 0o755
    FileUtils.install 'config.toml', "#{CREW_DEST_HOME}/config.toml", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Type 'vuls' to get started.

      Visit https://vuls.io/docs/en/tutorial-local-scan.html for more information.
    EOM
  end
end
