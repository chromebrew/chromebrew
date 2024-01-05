require 'package'

class Signal_desktop < Package
  description 'Private Messenger for Windows, Mac, and Linux'
  homepage 'https://signal.org/'
  version '6.43.1'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url 'https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_6.43.1_amd64.deb'
  source_sha256 '983c5916cfab236787924be499f96b6acd56a816bf1c15410e9764f4d29a0b61'

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

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/Signal', "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Signal/signal-desktop", "#{CREW_DEST_PREFIX}/bin/signal-desktop"
  end

  def self.postinstall
    ExitMessage.add "\nType 'signal-desktop' to get started.\n".lightblue
  end
end
