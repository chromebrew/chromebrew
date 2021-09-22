# Adapted from Arch Linux chafa PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/chafa/trunk/PKGBUILD

require 'package'

class Chafa < Package
  description 'Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.'
  homepage 'https://hpjansson.org/chafa/'
  version '1.8.0'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://github.com/hpjansson/chafa/releases/download/1.8.0/chafa-1.8.0.tar.xz'
  source_sha256 '21ff652d836ba207098c40c459652b2f1de6c8a64fbffc62e7c6319ced32286b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/1.8.0_armv7l/chafa-1.8.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/1.8.0_armv7l/chafa-1.8.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/1.8.0_x86_64/chafa-1.8.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8e4a30680cb863f3735e8e21f33332dae55aa894648719ac8f26028d99cc178e',
     armv7l: '8e4a30680cb863f3735e8e21f33332dae55aa894648719ac8f26028d99cc178e',
     x86_64: '0a7c5213a65a6058a766022ec58867f6c435a0759ee27d69727c43f2f9db2c9b'
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
