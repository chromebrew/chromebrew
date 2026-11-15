require 'package'

class Seamonkey < Package
  description 'Web-browser, advanced e-mail, newsgroup and feed client, IRC chat, and HTML editing made simple'
  homepage 'https://www.seamonkey-project.org/'
  version '2.53.24'
  license 'Mozilla Public License 2.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://archive.seamonkey-project.org/releases/#{version}/linux-x86_64/en-US/seamonkey-#{version}.en-US.linux-x86_64.tar.bz2"
  source_sha256 '63fbe1d0f5ca35bb228e47eb586a81c5787debfbc27a242129ea9e133429d82c'

  depends_on 'dbus_glib'
  depends_on 'gtk3'
  depends_on 'sommelier' => :logical

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/seamonkey"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/seamonkey"
    FileUtils.ln_s "#{CREW_PREFIX}/share/seamonkey/seamonkey", "#{CREW_DEST_PREFIX}/bin/seamonkey"
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('seamonkey', 'seamonkey')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('seamonkey', 'seamonkey')
  end

  def self.postremove
    if Dir.exist?("#{HOME}/.mozilla/firefox")
      Package.agree_to_remove("#{HOME}/.mozilla/seamonkey")
    else
      Package.agree_to_remove("#{HOME}/.mozilla")
    end
  end
end
