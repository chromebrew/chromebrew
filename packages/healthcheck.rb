require 'package'

class Healthcheck < Package
  description 'Linux system health check.'
  homepage 'https://github.com/SimplyLinuxFAQ/health-check-script'
  version '1cace5'
  source_url 'https://github.com/SimplyLinuxFAQ/health-check-script/archive/1cace54e871c69cd4bbbaeeb3b9e314d7f575b06.tar.gz'
  source_sha1 '203a5e8f0378c656a0d7f6b9e87d5cf217b18395'
  #source_sha256 '4f40995614da68da7422e2ba8e01815c569e3c1a268122a5e13a007899092630'

  depends_on 'sysstat'

  def self.install
    system "chmod +x health-check.sh"
    system "sed -i 's,usr/bin,usr/local/bin,' health-check.sh"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp health-check.sh #{CREW_DEST_DIR}/usr/local/bin/healthcheck"
  end
end
