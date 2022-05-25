require 'package'

class Libxfce4util < Package
  description 'Utility library for the Xfce4 desktop environment'
  homepage 'https://xfce.org/'
  version '4.17.1'
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/libxfce4util/4.17/libxfce4util-4.17.1.tar.bz2'
  source_sha256 '1942151f3c1f3732bc53dd9fd3b936f62067796dc47a33c60a0ad05d933d90f2'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfce4util/4.17.1_armv7l/libxfce4util-4.17.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfce4util/4.17.1_armv7l/libxfce4util-4.17.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfce4util/4.17.1_i686/libxfce4util-4.17.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfce4util/4.17.1_x86_64/libxfce4util-4.17.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '60931162f4dd81641a84a84c840426d9d188a960a9cc222bcbd15591e718af57',
     armv7l: '60931162f4dd81641a84a84c840426d9d188a960a9cc222bcbd15591e718af57',
       i686: '597083d2e0a9b254580295236747903e0c032e0bf05537c6c6576c416450e4f2',
     x86_64: 'bec77f6226c7fb69e215acc98c50da5c44189d089724672e607e9590c3ebc7b9'
  })

  depends_on 'gobject_introspection'

  def self.patch
    system 'filefix'
  end

  def self.build
    system <<~BUILD
      [ -x autogen.sh ] && env NOCONFIGURE='1' ./autogen.sh
      env #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}
      make
    BUILD
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
