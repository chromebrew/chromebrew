# Adapted from Arch Linux chafa PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/chafa/trunk/PKGBUILD

require 'package'

class Chafa < Package
  description 'Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.'
  homepage 'https://hpjansson.org/chafa/'
  version 'cf15d59'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://github.com/hpjansson/chafa.git'
  git_hashtag 'cf15d59da7ccc6a79f8900e21d0926bea08074e9'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/cf15d59_armv7l/chafa-cf15d59-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/cf15d59_armv7l/chafa-cf15d59-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/cf15d59_i686/chafa-cf15d59-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chafa/cf15d59_x86_64/chafa-cf15d59-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd53beb7ca506c4df22a1722a4de31c9f08d9726ea73af281c4dfe59019961512',
     armv7l: 'd53beb7ca506c4df22a1722a4de31c9f08d9726ea73af281c4dfe59019961512',
       i686: 'f75740d4e7863e7e7c8ef7bfa8270232a62456eadc3881ef67102791458bed48',
     x86_64: '5aec91cd2979e938db4da44cdf3251338e7f7d81e38939f19f680e2a11dea21b'
  })

  depends_on 'glib'
  depends_on 'libxslt'

  def self.build
    system 'autoreconf -fiv'
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS} \
      --without-tools \
      --enable-gtk-doc=no"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
