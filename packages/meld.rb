require 'buildsystems/meson'

class Meld < Meson
  description 'Meld is a visual diff and merge tool targeted at developers.'
  homepage 'https://meldmerge.org/'
  version '3.22.0-684e1e2-py3.12'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/meld.git'
  git_hashtag '684e1e27f31b4f0053da546a273a4ecf07df595f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9044c2ee4f70158c0f271a764f475c6a7cb095525699fe20c3ab6e55c3a622d',
     armv7l: 'c9044c2ee4f70158c0f271a764f475c6a7cb095525699fe20c3ab6e55c3a622d',
       i686: '738c8fe2c1df886e38587f69dddaecb928d615e19233ccc5c4fdb83f8c552478',
     x86_64: '0e8c2e68b57acfc2e826411a62c7bb5c5bea7303d4c82c84bb5e489af3182076'
  })

  depends_on 'desktop_file_utils' # L
  depends_on 'gtk3' # L
  depends_on 'gtksourceview_4' # L
  depends_on 'python3' # L
  depends_on 'py3_pycairo' # L
  depends_on 'py3_libxml2' # L

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    system "sed -i 's:#!/usr/bin/python3:#!/usr/bin/env python3:' #{CREW_DEST_PREFIX}/bin/meld"
  end
end
