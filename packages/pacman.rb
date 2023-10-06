require 'buildsystems/meson'

class Pacman < Meson
  description 'A library-based package manager with dependency support.'
  version '6.0.2'
  homepage 'http://www.archlinux.org/pacman/'
  license 'GPL 2'
  compatibility 'all'
  source_url 'https://sources.archlinux.org/other/pacman/pacman-6.0.2.tar.xz'
  source_sha256 '7d8e3e8c5121aec0965df71f59bedf46052c6cf14f96365c4411ec3de0a4c1a5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacman/6.0.2_armv7l/pacman-6.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacman/6.0.2_armv7l/pacman-6.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacman/6.0.2_i686/pacman-6.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacman/6.0.2_x86_64/pacman-6.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '69f339fc1237c24d6de532d8a1e9735f093ae2a81e7d6799c6f1376e6d0d31a9',
     armv7l: '69f339fc1237c24d6de532d8a1e9735f093ae2a81e7d6799c6f1376e6d0d31a9',
       i686: '00df0e54c4c3c885c8074d49869edffc77cce3dd36e8820a04d084cafa83c608',
     x86_64: 'c7033bc47124e20034fb00e60f7b6052d16958c6b6d0ef63907d8681de230251'
  })

  depends_on 'asciidoc' => :build
  depends_on 'bash' # pacman demands a bash newer than 4.0
  depends_on 'curl'
  depends_on 'fakeroot'
  depends_on 'gcc_lib' # R
  depends_on 'glibc'
  depends_on 'gpgme'
  depends_on 'libarchive'
  depends_on 'openssl' # R
  depends_on 'py3_setuptools' => :build # needed for Python 3.12 compatibility
  depends_on 'xzutils'

  meson_options "-Droot-dir=/usr/local \
             -Dmakepkg-template-dir=#{CREW_PREFIX}/share/makepkg-template \
             -Dscriptlet-shell=#{CREW_PREFIX}/bin/bash \
             -Dldconfig=/sbin/ldconfig \
             -Dpkg-ext=.pkg.tar.xz \
             -Dsrc-ext=.src.tar.gz"
end
