require 'package'

class Rustdesk < Package
  description 'An open-source remote desktop application designed for self-hosting, as an alternative to TeamViewer.'
  homepage 'https://rustdesk.com/'
  version '1.4.9'
  license 'AGPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.37'
  source_url({
    aarch64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     armv7l: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     x86_64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-x86_64.deb"
  })
  source_sha256({
    aarch64: '7c5f602f2978963fe00d75d69ec141261f27ad27920740d7c37313c402c486c8',
     armv7l: '7c5f602f2978963fe00d75d69ec141261f27ad27920740d7c37313c402c486c8',
     x86_64: '7244ba47c40e804172044bfbe659467c54ce46554c98e78c8c0406f1d612fda3'
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
  no_shrink

  def self.install
    dir = ARCH.eql?('x86_64') ? 'usr/share' : 'share'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv dir, CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/rustdesk/rustdesk", "#{CREW_DEST_PREFIX}/bin/rustdesk"
  end
end
