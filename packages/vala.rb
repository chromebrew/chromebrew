require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.53.2'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/vala.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.53.2_armv7l/vala-0.53.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.53.2_armv7l/vala-0.53.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.53.2_x86_64/vala-0.53.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '03a6379a478dd6103049a993a0e0ad04e62e2c71fa42bef139b322c914059ee1',
     armv7l: '03a6379a478dd6103049a993a0e0ad04e62e2c71fa42bef139b322c914059ee1',
     x86_64: '5c503b417af46f6f5ab79dc3d2cf63336e46cea9e73c6c56d0b80fc831e8d0ff'
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
