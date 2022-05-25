require 'package'

class Atkmm < Package
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.36.2'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/atkmm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm/2.36.2_armv7l/atkmm-2.36.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm/2.36.2_armv7l/atkmm-2.36.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm/2.36.2_i686/atkmm-2.36.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm/2.36.2_x86_64/atkmm-2.36.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '049d1efb8c411ac36328983605a54d54e3bc45587aa3ac9157f4b629be75f720',
     armv7l: '049d1efb8c411ac36328983605a54d54e3bc45587aa3ac9157f4b629be75f720',
       i686: '4ceaac05ebc9ae13009b10103249356131e260b7ce8ed3a3e57ad91f73f174e2',
     x86_64: 'ffe420ab3a9f104326cdb232bf5326767b07e4b5ecbc9af73909e53692b5c685'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_68' # R
  depends_on 'glib' # R
  depends_on 'libsigcplusplus3' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbuild-documentation=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
