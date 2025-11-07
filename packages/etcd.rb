require 'package'

class Etcd < Package
  description 'Distributed reliable key-value store for the most critical data of a distributed system'
  homepage 'https://etcd.io/'
  version '3.6.5'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/etcd-io/etcd/releases/download/v#{version}/etcd-v#{version}-linux-amd64.tar.gz"
  source_sha256 '66bad39ed920f6fc15fd74adcb8bfd38ba9a6412f8c7852d09eb11670e88cac3'

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
