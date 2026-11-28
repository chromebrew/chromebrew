require 'package'

class Strata < Package
  description 'Strata inference engine, OpenAI/Anthropic API on localhost, optional image input.'
  homepage 'https://github.com/niko1221/strata'
  version '0.2.23'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.33'
  source_url "https://github.com/Niko1221/Strata/releases/download/v#{version}/Strata-#{version}-linux-x86_64.AppImage"
  source_sha256 '335c9a242cc89b27ba8c76e9a8ceebbc7a4fa884a99f8701265e6579a1670409'

  depends_on 'sommelier' => :logical

  no_compile_needed
  no_shrink

  def self.build
    File.write 'strata.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/strata
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.install 'strata.sh', "#{CREW_DEST_PREFIX}/bin/strata", mode: 0o755
    FileUtils.install 'Strata.desktop', "#{CREW_DEST_PREFIX}/share/applications/Strata.desktop", mode: 0o644
    FileUtils.install 'strata-desktop.png', "#{CREW_DEST_PREFIX}/share/icons/strata-desktop.png", mode: 0o644
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/strata"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/strata"
  end

  def self.postinstall
    ExitMessage.add "\nType 'strata' to get started.\n"
  end

  def self.postremove
    config_dir = "#{HOME}/.strata"
    if Dir.exist?(config_dir)
      puts "\nWARNING: This will remove ALL strata data in #{config_dir} including models!\n".orange
      Package.agree_to_remove(config_dir)
    end
  end
end
