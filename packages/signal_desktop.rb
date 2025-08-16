require 'package'

class Signal_desktop < Package
  description 'Private Messenger for Windows, Mac, and Linux'
  homepage 'https://signal.org/'
  version '7.66.0'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_#{version}_amd64.deb"
  source_sha256 '02ef930e19f4b5d11c3e83cb17aef85b4ed895539e4fd8c9b817c45c07adc06e'

  no_compile_needed
  no_shrink

  depends_on 'at_spi2_core'
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.patch
    Dir.chdir 'usr/share/applications' do
      system "sed -i 's,/opt,#{CREW_PREFIX}/share,' signal-desktop.desktop"
      # See https://github.com/signalapp/Signal-Desktop/issues/6122.
      system "sed -i 's,StartupWMClass=Signal,StartupWMClass=signal,' signal-desktop.desktop"
      system "sed -i 's,%U,--enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --use-tray-icon %U,' signal-desktop.desktop"
    end
  end

  def self.build
    File.write 'signal.sh', <<~EOF
      #!/bin/bash
      LD_LIBRARY_PATH=#{CREW_PREFIX}/share/Signal:$LD_LIBRARY_PATH
      #{CREW_PREFIX}/share/Signal/signal-desktop "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/Signal', "#{CREW_DEST_PREFIX}/share"
    FileUtils.install 'signal.sh', "#{CREW_DEST_PREFIX}/bin/signal-desktop", mode: 0o755
    # FileUtils.ln_s "#{CREW_PREFIX}/share/Signal/signal-desktop", "#{CREW_DEST_PREFIX}/bin/signal-desktop"
  end

  def self.postinstall
    ExitMessage.add "\nType 'signal-desktop' to get started.\n"
  end
end
