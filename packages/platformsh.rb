require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '5.0.21'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/platformsh/cli/releases/download/#{version}/platform_#{version}_linux_amd64.tar.gz"
  source_sha256 '3bab32b2d63e7d18720eefdc9577ee401ea5bf61e0ce821eda4bb833082b4282'

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
