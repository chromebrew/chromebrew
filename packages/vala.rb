require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.52.4'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/vala.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.52.4_armv7l/vala-0.52.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.52.4_armv7l/vala-0.52.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.52.4_i686/vala-0.52.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.52.4_x86_64/vala-0.52.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '99147de6b7b758595d27359d4a6fa137f844b1d67807d8f0a14a5cf5ae201a4f',
     armv7l: '99147de6b7b758595d27359d4a6fa137f844b1d67807d8f0a14a5cf5ae201a4f',
       i686: 'accb24d01b54aed8876c3cb1ff79ec4c62e97dad3d59522d6ace946faf7cc809',
     x86_64: '85dd615b1ff6ccb1c6cf9940349624b8f0228c045ce275e2d2b5f304de79279d'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'autoconf213' => :build
  depends_on 'graphviz'
  depends_on 'libxslt'
  depends_on 'glib'
  depends_on 'dbus'

  def self.build
    # Required for building vala from git.
    system 'git fetch --tags'
    # Bootstrap vala
    FileUtils.mkdir_p 'bootstrap_install'
    system 'git clone https://gitlab.gnome.org/Archive/vala-bootstrap.git'
    Dir.chdir('vala-bootstrap') do
      system 'git checkout b2beeaccdf2307ced172646c2ada9765e1747b28'
      system 'touch */*.stamp'
      system 'autoreconf -fi'
      system 'VALAC=/no-valac ./configure --prefix=`pwd`/../bootstrap_install'
      system 'make'
      system 'make install'
    end

    system "#{CREW_ENV_OPTIONS} VALAC=`pwd`/bootstrap_install/bin/valac ./autogen.sh \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --disable-valadoc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
