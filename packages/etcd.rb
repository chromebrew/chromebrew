require 'package'

class Etcd < Package
  description 'Distributed reliable key-value store for the most critical data of a distributed system'
  homepage 'https://etcd.io/'
  version '3.7.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/etcd-io/etcd/releases/download/v#{version}/etcd-v#{version}-linux-amd64.tar.gz"
  source_sha256 'e8cd3fa8064c98137c5dbd78b76f969417ace84efb83c481041d7a52ffdd8fb9'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install %w[etcd etcdctl etcdutl], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nSee documentation: https://etcd.io/docs/v#{version.sub(/\.\d+$/, '')}.\n"
  end
end
