require 'package'

class Zcode < Package
  description 'ZCode is next-gen vibe coding for complex goals - with multiple agents and control from anywhere.'
  homepage 'https://zcode.z.ai/'
  version '3.17.2'
  license 'ZCode Terms of Service'
  compatibility 'x86_64'
  source_url "https://cdn-zcode.z.ai/zcode/electron/releases/#{version}/linux-x64/ZCode-#{version}-linux-x64.AppImage"
  source_sha256 '4a522d45727454188c56833275ae5b4d588ac3b2b87eedee5f7d98f8553a12e1'

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
