require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '5.0.14'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/platformsh/cli/releases/download/#{version}/platform_#{version}_linux_amd64.tar.gz"
  source_sha256 '8aa453be78808427af14780b9e4fe5c5c0f3c40ea251910257463ec14f1e820e'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install 'platform', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
    FileUtils.install 'completion/bash/platform.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/platform.bash", mode: 0o644
    FileUtils.install 'completion/bash/upsun.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/upsun.bash", mode: 0o644
  end
end
