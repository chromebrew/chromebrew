require 'package'

class Rustdesk < Package
  description 'An open-source remote desktop application designed for self-hosting, as an alternative to TeamViewer.'
  homepage 'https://rustdesk.com/'
  version '1.4.4'
  license 'AGPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.37'
  source_url({
    aarch64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     armv7l: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     x86_64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-x86_64.deb"
  })
  source_sha256({
    aarch64: '037d7a8387b162973228d07377fe366fd6e7388f293d1cb5f7f8f5f879644560',
     armv7l: '037d7a8387b162973228d07377fe366fd6e7388f293d1cb5f7f8f5f879644560',
     x86_64: 'db722ef63ee3e1e410ab34aba7b6dd3b416a61516f3b744f9b9707ee9639e46c'
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
