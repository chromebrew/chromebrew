require 'package'

class Masscan < Package
  description 'TCP port scanner, spews SYN packets asynchronously, scanning entire Internet in under 5 minutes.'
  homepage 'https://github.com/robertdavidgraham/masscan'
  compatibility 'all'
  license 'AGPL-3'
  version '1.3.2'
  source_url 'https://github.com/robertdavidgraham/masscan.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c6530863a485cb08443373dc9f50ff732ec2ba9ce9fd68ef60b8bde8b19ac37',
     armv7l: '0c6530863a485cb08443373dc9f50ff732ec2ba9ce9fd68ef60b8bde8b19ac37',
       i686: '8f34eb82c46d061aab58c96eb1207953400d34a1f7bebf3497fb21f4b8f39bc5',
     x86_64: 'dd63dbae13a4998ce9cd26743296983406b5762042af54854f4c37db206dd62c'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libpcap' => :library

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'bin/masscan', "#{CREW_DEST_PREFIX}/bin/masscan", mode: 0o755
    FileUtils.install 'doc/masscan.8', "#{CREW_DEST_MAN_PREFIX}/man8/masscan.8", mode: 0o644
  end
end
