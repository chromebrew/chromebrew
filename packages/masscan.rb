require 'package'

class Masscan < Package
  description 'TCP port scanner, spews SYN packets asynchronously, scanning entire
Internet in under 5 minutes.'
  homepage 'https://github.com/robertdavidgraham/masscan'
  version '1.0.4'
  source_url 'https://github.com/robertdavidgraham/masscan/archive/1.0.4.tar.gz'
  source_sha256 '51de345f677f46595fc3bd747bfb61bc9ff130adcbec48f3401f8057c8702af9'

  depends_on 'libpcap'

  def self.build
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp bin/masscan #{CREW_DEST_DIR}/usr/local/bin"
  end
end
