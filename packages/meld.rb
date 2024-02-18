require 'buildsystems/meson'

class Meld < Meson
  description 'Meld is a visual diff and merge tool targeted at developers.'
  homepage 'https://meldmerge.org/'
  @_ver = '3.22.1'
  version "#{@_ver}-py3.12"
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/meld.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c9c00dfe88d9afb6f486cf3e2cd8788fb45a27992e856056ee98960e4528547',
     armv7l: '8c9c00dfe88d9afb6f486cf3e2cd8788fb45a27992e856056ee98960e4528547',
     x86_64: '5fa48ea39ba4f272052001622f828eb2b67eed4065037ab93d8a20baeccd75b1'
  })

  depends_on 'desktop_file_utils' # L
  depends_on 'gtk3' # L
  depends_on 'gtksourceview_4' # L
  depends_on 'py3_libxml2' # L
  depends_on 'py3_pycairo' # L
  depends_on 'python3' # L

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    system "sed -i 's:#!/usr/bin/python3:#!/usr/bin/env python3:' #{CREW_DEST_PREFIX}/bin/meld"
  end
end
