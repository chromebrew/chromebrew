# Adapted from Arch Linux chafa PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/chafa/trunk/PKGBUILD

require 'package'

class Chafa < Package
  description 'Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.'
  homepage 'https://hpjansson.org/chafa/'
  version '1.6.1'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://github.com/hpjansson/chafa/releases/download/1.6.1/chafa-1.6.1.tar.xz'
  source_sha256 '76c98930e99b3e5fadb986148b99d65636e9e9619124e568ff13d364ede89fa5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/1.6.1_armv7l/chafa-1.6.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/1.6.1_armv7l/chafa-1.6.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/1.6.1_i686/chafa-1.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/1.6.1_x86_64/chafa-1.6.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3b1070f6bb7c4e3756fec41b9241b7823d34c09cbedf59fb7a700921e06cb561',
     armv7l: '3b1070f6bb7c4e3756fec41b9241b7823d34c09cbedf59fb7a700921e06cb561',
       i686: 'a2d4ff382d205c1522b8155b999b5499fea83815b9f71f8697256f93174cc288',
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
