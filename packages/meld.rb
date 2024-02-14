require 'buildsystems/meson'

class Meld < Meson
  description 'Meld is a visual diff and merge tool targeted at developers.'
  homepage 'https://meldmerge.org/'
  version '3.22.0-2f7dbde-py3.12'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/meld.git'
  git_hashtag '2f7dbdedd2b022fce238ba25e182929e0a8cea1e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9044c2ee4f70158c0f271a764f475c6a7cb095525699fe20c3ab6e55c3a622d',
     armv7l: 'c9044c2ee4f70158c0f271a764f475c6a7cb095525699fe20c3ab6e55c3a622d',
     x86_64: '0e8c2e68b57acfc2e826411a62c7bb5c5bea7303d4c82c84bb5e489af3182076'
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
