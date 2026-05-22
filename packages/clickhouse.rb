require 'package'

class Clickhouse < Package
  description 'Real-time analytics DBMS'
  homepage 'https://clickhouse.com/'
  version '26.5.1.882-stable'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/ClickHouse/ClickHouse/releases/download/v#{version}/clickhouse-common-static-#{version.split('-')[0]}-amd64.tgz"
  source_sha256 'd93e0e9f6f684f0b233b82cbdf96e8cc9428b57447c5f4ed2b7d72368c974e66'

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.mv 'usr/bin/', CREW_DEST_PREFIX.to_s
    FileUtils.mv 'usr/share/', CREW_DEST_PREFIX.to_s
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-clickhouse", <<~EOF
      source #{CREW_PREFIX}/share/bash-completion/completions/clickhouse
    EOF
  end

  def self.postinstall
    ExitMessage.add "\nType 'clickhouse' to get started.\n"
  end
end
