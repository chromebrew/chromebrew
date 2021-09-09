require 'package'

class Cros_adapta < Package
  description 'Gtk+ compatible themes for styling UI elements from Crostini to match Chrome OS defaults.'
  homepage 'https://chromium.googlesource.com/chromiumos/third_party/cros-adapta/'
  version '20181204'
  license 'CC-SA-4.0, GPL-2'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/cros-adapta.git'
  git_hashtag 'eb6d8c1832b9181926df107faf41a80887fd982c'

  def self.build
    @_env = <<~EOF
      set -a
      : ${GTK2_RC_FILES:=#{CREW_PREFIX}/share/themes/CrosAdapta/gtk-2.0/gtkrc}
      : ${GTK_THEME:=CrosAdapta}
    EOF
  end

  def self.install
    @_dest_dir = "#{CREW_DEST_PREFIX}/share/themes/CrosAdapta/"
    FileUtils.mkdir_p [ @_dest_dir, "#{CREW_DEST_PREFIX}/etc/env.d/" ]
    FileUtils.mv Dir['gtk*/'], @_dest_dir
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/cros_adapta", @_env
  end

  def self.postinstall
    puts nil, <<~EOT.lightblue
      To complete the installation, execute the following:
      source #{CREW_PREFIX}/etc/profile
    EOT
  end
end