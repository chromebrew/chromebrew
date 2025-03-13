require 'package'

class Appflowy < Package
  description 'AI collaborative workspace where you achieve more without losing control of your data. The best open source alternative to Notion.'
  homepage 'https://www.appflowy.io/'
  version '0.8.6'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/AppFlowy-IO/AppFlowy/releases/download/#{version}/AppFlowy-#{version}-linux-x86_64.tar.gz"
  source_sha256 'a60158bb548b50c4e95d05d508313eeb0018d0052accea3f25b2368b8bbb5359'

  depends_on 'gtk3'
  depends_on 'gobject_introspection'
  depends_on 'gnome_common'
  depends_on 'keybinder'
  depends_on 'libnotify'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/AppFlowy"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/AppFlowy"
    FileUtils.ln_s "#{CREW_PREFIX}/share/AppFlowy/AppFlowy", "#{CREW_DEST_PREFIX}/bin/appflowy"
  end

  def self.postinstall
    ExitMessage.add "\nType 'appflowy' to get started.\n"
  end
end
