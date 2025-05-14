require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '5.1.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/platformsh/cli/releases/download/#{version}/platform_#{version}_linux_amd64.tar.gz"
  source_sha256 'dad7a987a3b3825e464dc91e344c51a82a68512082345ee6451cb7c16c4e7365'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.install
    FileUtils.install 'platform', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
    FileUtils.install 'completion/bash/platform.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/platform.bash", mode: 0o644
    FileUtils.install 'completion/bash/upsun.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/upsun.bash", mode: 0o644
  end
end
