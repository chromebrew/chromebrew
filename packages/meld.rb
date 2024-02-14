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
    aarch64: '8b120c9f6920d07e12fbcd333d8df4e118fa0d89f13dc2fc8b77726a8f7325d7',
     armv7l: '8b120c9f6920d07e12fbcd333d8df4e118fa0d89f13dc2fc8b77726a8f7325d7',
     x86_64: '1a2072e7778760cadadc01e6fd716eb14bcf2f34a1b51b967ac7f23ab1d5021e'
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
