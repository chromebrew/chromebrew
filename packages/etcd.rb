require 'package'

class Etcd < Package
  description 'Distributed reliable key-value store for the most critical data of a distributed system'
  homepage 'https://etcd.io/'
  version '3.5.21'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/etcd-io/etcd/releases/download/v#{version}/etcd-v#{version}-linux-amd64.tar.gz"
  source_sha256 'adddda4b06718e68671ffabff2f8cee48488ba61ad82900e639d108f2148501c'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install %w[etcd etcdctl etcdutl], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nSee documentation: https://etcd.io/docs/latest.\n"
  end
end
