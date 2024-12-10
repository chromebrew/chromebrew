require 'package'

class Vuls < Package
  description 'Agent-less vulnerability scanner'
  homepage 'https://vuls.io/'
  version '0.28.0'
  license 'GPL-3.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/future-architect/vuls/releases/download/v#{version}/future-vuls_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/future-architect/vuls/releases/download/v#{version}/future-vuls_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/future-architect/vuls/releases/download/v#{version}/future-vuls_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/future-architect/vuls/releases/download/v#{version}/future-vuls_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '2ff4b3f0e63170ab6905c5305590f1e4ee9b50a65db381eaddcf36a86dc96f8a',
     armv7l: '2ff4b3f0e63170ab6905c5305590f1e4ee9b50a65db381eaddcf36a86dc96f8a',
       i686: '7db11d9be1e9957b40ff2312bcfdc9f85b226bb8835df2c7844645b0a870f687',
     x86_64: '3a824cf59c88bc21aac7b7af55a460bdead603ed7fbd077a4907a28346d3f594'
  })

  binary_compression 'tar.zst'
  binary_sha256({
    aarch64: '7168b0a1047b35c68100a30becd5c9573731e4a20ed7d9d9a5b95e7d76c063a1',
     armv7l: '7168b0a1047b35c68100a30becd5c9573731e4a20ed7d9d9a5b95e7d76c063a1',
       i686: 'f82652a73e25c17d866e2e94e016be05911a90458cf849b1d9e3be4aaf04e7ad',
     x86_64: '28d880185524a4925c4bc743e39c41a2f45752ca406eb741a3fd8e2a16afd4b2'
  })

  depends_on 'go' => :build
  depends_on 'revive' => :build
  depends_on 'glibc' # R
  depends_on 'sqlite' # R

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
