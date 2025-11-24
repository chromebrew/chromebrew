require 'package'

class Etcd < Package
  description 'Distributed reliable key-value store for the most critical data of a distributed system'
  homepage 'https://etcd.io/'
  version '3.6.6'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/etcd-io/etcd/releases/download/v#{version}/etcd-v#{version}-linux-amd64.tar.gz"
  source_sha256 '887afaa4a99f22d802ccdfbe65730a5e79aa5c9ce2c8799c67e9d804c50ecedb'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install %w[etcd etcdctl etcdutl], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nSee documentation: https://etcd.io/docs/v#{version.sub(/\.\d+$/, '')}.\n"
  end
end
