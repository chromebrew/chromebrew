require 'package'

class Rustdesk < Package
  description 'An open-source remote desktop application designed for self-hosting, as an alternative to TeamViewer.'
  homepage 'https://rustdesk.com/'
  version '1.3.6'
  license 'AGPL-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.37'
  source_url({
    aarch64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     armv7l: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     x86_64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-x86_64.deb"
  })
  source_sha256({
    aarch64: 'f1b27c08755b94c2636acf7069d4453fdfeca7f3ea7954b10dfc0266b45a6f00',
     armv7l: 'f1b27c08755b94c2636acf7069d4453fdfeca7f3ea7954b10dfc0266b45a6f00',
     x86_64: 'd4b9b47cbdf7786c3116bb278c6c5a8b8b058eecc23646e798b7f5961539c801'
  })

  depends_on 'gtk3'
  depends_on 'libaom'
  depends_on 'libsciter_gtk'
  depends_on 'libvpx'
  depends_on 'libyuv'
  depends_on 'opus'
  depends_on 'pulseaudio'
  depends_on 'xdotool'

  no_compile_needed

  def self.install
    dir = ARCH.eql?('x86_64') ? 'usr/share' : 'share'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv dir, CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/rustdesk/rustdesk", "#{CREW_DEST_PREFIX}/bin/rustdesk"
  end
end
