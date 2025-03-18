require 'package'

class Qortal_hub < Package
  description 'Desktop interface for Qortal'
  homepage 'https://qortal.dev/'
  version '0.5.2'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/Qortal/Qortal-Hub/releases/download/v#{version}/Qortal-Hub_#{version}.AppImage"
  source_sha256 'b52e920dfd48edd57e07befee5cd9d3a930d49c9a3d52509afef7726a234ec35'

  depends_on 'gtk3'
  depends_on 'sommelier'

  no_shrink
  no_compile_needed

  def self.build
    File.write 'qortal_hub.sh', <<~EOF
      #!/bin/bash
      export APPDIR=#{CREW_PREFIX}/share/qortal_hub
      export LD_LIBRARY_PATH="#{CREW_PREFIX}/share/qortal_hub/usr/lib:#{CREW_LIB_PREFIX}"
      cd $APPDIR
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX.to_s
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/qortal_hub"
    FileUtils.install 'qortal_hub.sh', "#{CREW_DEST_PREFIX}/bin/qortal-hub", mode: 0o755
    FileUtils.install 'Qortal Hub.desktop', "#{CREW_DEST_PREFIX}/share/applications/Qortal Hub.desktop", mode: 0o644
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/qortal_hub"
  end

  def self.postinstall
    ExitMessage.add "\nType 'qortal-hub' to get started.\n"
  end
end
