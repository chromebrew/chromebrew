# Adapted from Arch Linux gpp PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=gpp

require 'buildsystems/autotools'

class Gpp < Autotools
  description 'A general-purpose preprocessor with customizable syntax, suitable for a wide range of preprocessing tasks'
  homepage 'https://github.com/logological/gpp'
  version '2.28'
  license 'LGPL2.1'
  compatibility 'all'
  source_url 'https://github.com/logological/gpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '250d4545d879fb41bcacd52fbb2ba52b3a5d2ca2b7517f3e539e518a447d3706',
     armv7l: '250d4545d879fb41bcacd52fbb2ba52b3a5d2ca2b7517f3e539e518a447d3706',
     i686: '1be2619edcb83802790428e1663cd2317436d667ac5e416ce2401a7f1a6a437f',
     x86_64: '6b373f11e39a740775caacaf6d7affaadd9327a33d791a636ac5a26b7f38ccea'
  })

  depends_on 'glibc' # R

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/gpp", "#{CREW_DEST_PREFIX}/bin/#{CREW_TGT}-gpp"
  end
end
