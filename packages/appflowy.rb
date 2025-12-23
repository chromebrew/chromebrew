require 'package'

class Appflowy < Package
  description 'AI collaborative workspace where you achieve more without losing control of your data. The best open source alternative to Notion.'
  homepage 'https://www.appflowy.io/'
  version '0.10.8'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/AppFlowy-IO/AppFlowy/releases/download/#{version}/AppFlowy-#{version}-linux-x86_64.tar.gz"
  source_sha256 'f349c92e2aa901243c7798be694db6e076deaa1dd59d7731fb4025e57bbb5a76'

  depends_on 'gtk3' # R
  depends_on 'gobject_introspection' # R
  depends_on 'gnome_common' # R
  depends_on 'gstreamer' # R
  depends_on 'keybinder' # R
  depends_on 'libnotify' # R
  depends_on 'libxss' # R

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/AppFlowy"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/AppFlowy"
    FileUtils.ln_s "#{CREW_PREFIX}/share/AppFlowy/AppFlowy", "#{CREW_DEST_PREFIX}/bin/appflowy"
    if File.exist?("#{CREW_PREFIX}/opt/glibc-libs/libpthread.so.0") && !File.exist?("#{CREW_LIB_PREFIX}/libpthread.so.0")
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.ln_s "#{CREW_PREFIX}/opt/glibc-libs/libpthread.so.0", "#{CREW_DEST_LIB_PREFIX}/libpthread.so.0"
    end
  end

  def self.postinstall
    ExitMessage.add "\nType 'appflowy' to get started.\n"
  end
end
