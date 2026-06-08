require 'package'

class Healthcheck < Package
  description 'Linux system health check.'
  homepage 'https://github.com/SimplyLinuxFAQ/health-check-script'
  version '4.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/SimplyLinuxFAQ/health-check-script.git'
  git_hashtag "v#{version}"

  depends_on 'lsb_release' => :executable
  depends_on 'dmidecode' => :executable
  depends_on 'sysstat' => :executable
  depends_on 'util_linux' => :executable

  no_compile_needed

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' health-check.sh"
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
