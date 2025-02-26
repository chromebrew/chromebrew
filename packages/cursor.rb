require 'package'

class Cursor < Package
  description 'The AI Code Editor'
  homepage 'https://www.cursor.com/'
  version '0.45.15'
  license 'Cursor EULA'
  compatibility 'x86_64'
  source_url "https://anysphere-binaries.s3.us-east-1.amazonaws.com/production/client/linux/x64/appimage/Cursor-#{version}-73dd83bb6f8e3a3704ad8078a8e455ac6d4260d1.deb.glibc2.25-x86_64.AppImage"
  source_sha256 'c1d603e358dd2cb9971bb77b266d7f43d74524cd1c2ae90b7d05c6bd9f3461d5'

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
