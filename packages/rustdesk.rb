require 'package'

class Rustdesk < Package
  description 'An open-source remote desktop application designed for self-hosting, as an alternative to TeamViewer.'
  homepage 'https://rustdesk.com/'
  version '1.5.3'
  license 'AGPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.37'
  source_url({
    aarch64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     armv7l: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-armv7-sciter.deb",
     x86_64: "https://github.com/rustdesk/rustdesk/releases/download/#{version}/rustdesk-#{version}-x86_64.deb"
  })
  source_sha256({
    aarch64: '2f048f748505c2a46da060cc9a6fb2ac4462bdb37db2c981f931ae4e4d6ed3d5',
     armv7l: '2f048f748505c2a46da060cc9a6fb2ac4462bdb37db2c981f931ae4e4d6ed3d5',
     x86_64: '81096d2f65fd43352540c351bca15bb0712a2a6f9efa4c95e9fff25cb97b3b81'
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
