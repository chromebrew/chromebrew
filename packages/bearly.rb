require 'package'

class Bearly < Package
  description 'Bearly makes you 10x faster by adding state of the art AI to your workflow.'
  homepage 'https://bearly.ai/'
  version '5.0.3'
  license 'Unknown'
  compatibility 'x86_64'
  source_url "https://github.com/bearlyai/releases/releases/download/v#{version}/Bearly-#{version}.AppImage"
  source_sha256 '2260ec1880d3dfdffd0b0f79d7dab972cea1286ec26b2ca6ceedf46dc6d50d0b'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'sommelier' => :logical

  def self.patch
    system "sed -i 's,AppRun,bearly,' bearly.desktop"
    system "sed -i '24iAPPDIR=#{CREW_PREFIX}/share/bearly' AppRun"
  end

  def self.build
    File.write 'bearly.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/bearly
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bearly"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'bearly.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'bearly.sh', "#{CREW_DEST_PREFIX}/bin/bearly", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/bearly"
  end

  def self.postinstall
    ExitMessage.add "\nType 'bearly' to get started.\n".lightblue
  end
end
