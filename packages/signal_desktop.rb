require 'package'

class Signal_desktop < Package
  description 'Private Messenger for Windows, Mac, and Linux'
  homepage 'https://signal.org/'
  version '5.34.0'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url 'SKIP'

  depends_on 'alien' => :build
  depends_on 'at_spi2_atk'
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    system "curl -L#O http://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_#{version}_amd64.deb"
    unless Digest::SHA256.hexdigest( File.read("signal-desktop_#{version}_amd64.deb") ) == 'b94e1626d77dab0ae31e0b0ad280e0fe909fff995f361a0c0c477f9475272f09'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
    system "alien -tc signal-desktop_#{version}_amd64.deb"
    system "tar xvf signal-desktop-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'opt/Signal', "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Signal/signal-desktop", "#{CREW_DEST_PREFIX}/bin/signal-desktop"
  end

  def self.postinstall
    puts "\nType 'signal-desktop' to get started.\n".lightblue
  end
end
