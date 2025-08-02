require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '5.2.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/platformsh/cli/releases/download/#{version}/platform_#{version}_linux_amd64.tar.gz"
  source_sha256 'a2e11a2c53738ce373dde65ab1bad6eac5aafc21232a2f33d0dd34e69ef82995'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.install
    FileUtils.install 'platform', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
    FileUtils.install 'completion/bash/platform.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/platform.bash", mode: 0o644
    FileUtils.install 'completion/bash/upsun.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/upsun.bash", mode: 0o644
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.platformsh")
  end
end
