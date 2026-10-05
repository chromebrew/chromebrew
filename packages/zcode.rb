require 'package'

class Zcode < Package
  description 'ZCode is next-gen vibe coding for complex goals - with multiple agents and control from anywhere.'
  homepage 'https://zcode.z.ai/'
  version '3.14.4'
  license 'ZCode Terms of Service'
  compatibility 'x86_64'
  source_url "https://cdn-zcode.z.ai/zcode/electron/releases/#{version}/linux-x64/ZCode-#{version}-linux-x64.AppImage"
  source_sha256 '4b4631987172fd975aa1f85fa0dc1f55ac1c756b26bd8ab18d68592ed9391182'

  no_compile_needed

  depends_on 'gtk3' => :executable
  depends_on 'sommelier' => :logical

  def self.build
    File.write 'zcode.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/zcode
      GDK_BACKEND=x11 ./zcode --no-sandbox "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.install 'zcode.desktop', "#{CREW_DEST_PREFIX}/share/applications/zcode.desktop", mode: 0o644
    FileUtils.install 'zcode.sh', "#{CREW_DEST_PREFIX}/bin/zcode", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zcode"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/zcode"
  end

  def self.postinstall
    ExitMessage.add "\nType 'zcode' to get started.\n"
  end
end
