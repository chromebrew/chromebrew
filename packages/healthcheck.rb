require 'package'

class Healthcheck < Package
  description 'Linux system health check.'
  homepage 'https://github.com/SimplyLinuxFAQ/health-check-script'
  version '4.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/SimplyLinuxFAQ/health-check-script.git'
  git_hashtag "v#{version}"

  depends_on 'lsb_release'
  depends_on 'dmidecode'
  depends_on 'sysstat'

  no_compile_needed

  def self.patch
    system "sed -i 's,usr/bin,usr/local/bin,' health-check.sh"
  end

  def self.install
    FileUtils.install 'health-check.sh', "#{CREW_DEST_PREFIX}/bin/healthcheck", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add <<~EOT

      To execute, enter the following:
      sudo healthcheck
    EOT
  end
end
