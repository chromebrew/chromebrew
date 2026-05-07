require 'package'

class Clickhouse < Package
  description 'Real-time analytics DBMS'
  homepage 'https://clickhouse.com/'
  version '26.4.1.1141-stable'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/ClickHouse/ClickHouse/releases/download/v#{version}/clickhouse-common-static-#{version.split('-')[0]}-amd64.tgz"
  source_sha256 '7b3825fdcbd35880915c178f2b731787315d9443acb20c72b9e0cc32abf5a73b'

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
