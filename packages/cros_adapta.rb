require 'package'

class Cros_adapta < Package
  description 'Gtk+ compatible themes for styling UI elements from Crostini to match Chrome OS defaults.'
  homepage 'https://chromium.googlesource.com/chromiumos/third_party/cros-adapta/'
  version '20181204'
  license 'CC-SA-4.0, GPL-2'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/cros-adapta.git'
  git_hashtag 'eb6d8c1832b9181926df107faf41a80887fd982c'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cros_adapta/20181204_armv7l/cros_adapta-20181204-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cros_adapta/20181204_armv7l/cros_adapta-20181204-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cros_adapta/20181204_x86_64/cros_adapta-20181204-chromeos-x86_64.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cros_adapta/20181204_x86_64/cros_adapta-20181204-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6df899ac5034b5abcbfbe6f2bf920fb6dbe1b4ce5a72b725ca69e70273fe8d2f',
     armv7l: '6df899ac5034b5abcbfbe6f2bf920fb6dbe1b4ce5a72b725ca69e70273fe8d2f',
       i686: 'e8d3072f0b887f74b6474290f712827f78b758c288f14605dd138673abfe3d98',
     x86_64: 'e8d3072f0b887f74b6474290f712827f78b758c288f14605dd138673abfe3d98'
  })

  def self.build
    @_env = <<~EOF
      set -a
      : ${GTK2_RC_FILES:=#{CREW_PREFIX}/share/themes/CrosAdapta/gtk-2.0/gtkrc}
      : ${GTK_THEME:=CrosAdapta}
    EOF
  end

  def self.install
    @_dest_dir = "#{CREW_DEST_PREFIX}/share/themes/CrosAdapta/"
    FileUtils.mkdir_p [@_dest_dir, "#{CREW_DEST_PREFIX}/etc/env.d/"]
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
