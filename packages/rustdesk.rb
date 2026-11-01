require 'package'

class Rustdesk < Package
  description 'An open-source remote desktop application designed for self-hosting, as an alternative to TeamViewer.'
  homepage 'https://rustdesk.com/'
  version '1.5.1'
  license 'AGPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.37'
  source_url({
    aarch64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     armv7l: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     x86_64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-x86_64.deb"
  })
  source_sha256({
    aarch64: '0c5b0f9f98b0b547ee029bb8a67cfa13180bcbedd4757138528e045b19a91406',
     armv7l: '0c5b0f9f98b0b547ee029bb8a67cfa13180bcbedd4757138528e045b19a91406',
     x86_64: '11e0af5f25e591358fa5190db96a808e14289dbe32b66e5cca8e230e28e8d479'
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
