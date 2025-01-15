require 'package'

class Clickhouse < Package
  description 'Real-time analytics DBMS'
  homepage 'https://clickhouse.com/'
  version '24.12.3.47'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/ClickHouse/ClickHouse/releases/download/v#{version}-stable/clickhouse-common-static-#{version}-amd64.tgz"
  source_sha256 'd437fab107d39bfda379041181313e8d4d1eacc12b3f890349b247838de6181f'

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
