require 'package'

class Flatseal < Package
  description 'Flatseal is a graphical utility to review and modify permissions from your Flatpak applications.'
  homepage 'https://github.com/tchx84/Flatseal/'
  version '1.7.5'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/tchx84/Flatseal.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatseal/1.7.5_armv7l/flatseal-1.7.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatseal/1.7.5_armv7l/flatseal-1.7.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatseal/1.7.5_i686/flatseal-1.7.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatseal/1.7.5_x86_64/flatseal-1.7.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fea48523a45f8cec6dae017c180aefabe2d2ffca20068f10d472638fefc81aaa',
     armv7l: 'fea48523a45f8cec6dae017c180aefabe2d2ffca20068f10d472638fefc81aaa',
       i686: 'c54b53817617660c46c4386635cbf94309c45c76cac25e86d75a63d294788cf4',
     x86_64: '649ba5f9085199a3e2ec7e30bd1db27a07d17a6c25202da8c3a54b948e00fd2c'
  })

  depends_on 'libhandy'
  depends_on 'desktop_file_utils'
  depends_on 'gjs'
  depends_on 'gtk3'
  depends_on 'webkit2gtk'
  depends_on 'sommelier'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'samu -C builddir'
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    FileUtils.symlink 'com.github.tchx84.Flatseal', "#{CREW_DEST_PREFIX}/bin/flatseal"
  end
end
