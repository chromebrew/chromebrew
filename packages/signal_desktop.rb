require 'package'

class Signal_desktop < Package
  description 'Private Messenger for Windows, Mac, and Linux'
  homepage 'https://signal.org/'
  version '6.42.0'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url 'https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_6.42.0_amd64.deb'
  source_sha256 'b86b15bff27c78c8cf39d52cfbc19c628a72f43da0dd25214b4f5b6a7ac0ea16'

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
    puts "\nType 'signal-desktop' to get started.\n".lightblue
  end
end
