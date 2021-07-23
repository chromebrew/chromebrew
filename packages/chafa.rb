# Adapted from Arch Linux chafa PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/chafa/trunk/PKGBUILD

require 'package'

class Chafa < Package
  description 'Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.'
  homepage 'https://hpjansson.org/chafa/'
  version '1.6.1'
  license 'LGPL'
  compatibility 'x86_64'
  source_url 'https://github.com/hpjansson/chafa/releases/download/1.6.1/chafa-1.6.1.tar.xz'
  source_sha256 '76c98930e99b3e5fadb986148b99d65636e9e9619124e568ff13d364ede89fa5'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/1.6.1_x86_64/chafa-1.6.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: '4b3fd102523ce0458a897bcd0ce1bbe8c60e30eb830e4aa98cedb782576795e6'
  })

  depends_on 'imagemagick7' => :build
  depends_on 'freetype_sub' => :build
  depends_on 'libxslt'
  depends_on 'gtk_doc' => ':build'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
