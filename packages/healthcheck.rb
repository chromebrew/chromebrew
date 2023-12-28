require 'package'

class Healthcheck < Package
  description 'Linux system health check.'
  homepage 'https://github.com/SimplyLinuxFAQ/health-check-script'
  version '1cace5'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/SimplyLinuxFAQ/health-check-script/archive/1cace54e871c69cd4bbbaeeb3b9e314d7f575b06.tar.gz'
  source_sha256 '4f40995614da68da7422e2ba8e01815c569e3c1a268122a5e13a007899092630'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/healthcheck/1cace5_armv7l/healthcheck-1cace5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/healthcheck/1cace5_armv7l/healthcheck-1cace5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/healthcheck/1cace5_i686/healthcheck-1cace5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/healthcheck/1cace5_x86_64/healthcheck-1cace5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b2859389bc7e8822e63fc6d793b40b298c9f47ca69dacfe274e891b62ce6c750',
     armv7l: 'b2859389bc7e8822e63fc6d793b40b298c9f47ca69dacfe274e891b62ce6c750',
       i686: 'a4d16ed000a890e88db285a5f8a8e81903da7e474c4a4fe641d431e253fe14c2',
     x86_64: 'e73a9d6a5d50c759d0f0de7c9c862aba28d4d2fbee17c9f5aa1b7b04e374fb96'
  })

  depends_on 'lsb_release'
  depends_on 'dmidecode'
  depends_on 'sysstat'

  def self.install
    FileUtils.chmod 0o755, 'health-check.sh'
    system "sed -i 's,usr/bin,usr/local/bin,' health-check.sh"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp 'health-check.sh', "#{CREW_DEST_PREFIX}/bin/healthcheck"
  end

  def self.postinstall
    puts <<~EOT.lightblue

      To execute, enter the following:
      sudo healthcheck

    EOT
  end
end
