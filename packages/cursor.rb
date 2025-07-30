require 'package'

class Cursor < Package
  description 'The AI Code Editor'
  homepage 'https://www.cursor.com/'
  version '1.3.5'
  license 'Cursor EULA'
  compatibility 'x86_64'
  source_url "https://downloads.cursor.com/production/9f33c2e793460d00cf95c06d957e1d1b8135fadd/linux/x64/Cursor-#{version}-x86_64.AppImage"
  source_sha256 '81f9c18b3c2c4e85e72f74e6ae45bf9534de7e8f9c37a50f2575372442ec4534'

  no_compile_needed
  no_shrink

  depends_on 'gdk_base'
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,AppRun,cursor,' cursor.desktop"
  end

  def self.build
    File.write 'cursor.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/cursor
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.install 'cursor.desktop', "#{CREW_DEST_PREFIX}/share/applications/cursor.desktop", mode: 0o644
    FileUtils.install 'cursor.sh', "#{CREW_DEST_PREFIX}/bin/cursor", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/cursor"
  end

  def self.postinstall
    ExitMessage.add "\nType 'cursor' to get started.\n"
  end
end
