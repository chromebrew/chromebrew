require 'package'

class Qortal_hub < Package
  description 'Desktop interface for Qortal'
  homepage 'https://qortal.dev/'
  version '2.0.1'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/Qortal/Qortal-Hub/releases/download/v#{version}/Qortal-Hub.AppImage"
  source_sha256 '455ee347c922b72d86f480b6921a49904c3516a7dfa027f6425474c92b091b14'

  depends_on 'gtk3'
  depends_on 'sommelier' => :logical

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
    FileUtils.install 'qortal-hub.desktop', "#{CREW_DEST_PREFIX}/share/applications/qortal-hub.desktop", mode: 0o644
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/qortal_hub"
  end

  def self.postinstall
    ExitMessage.add "\nType 'qortal-hub' to get started.\n"
  end
end
