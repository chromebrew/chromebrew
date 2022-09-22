require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.56.3'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/vala.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.56.3_armv7l/vala-0.56.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.56.3_armv7l/vala-0.56.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.56.3_i686/vala-0.56.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.56.3_x86_64/vala-0.56.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '86d5a6f17c1221eb24c2802342c2645074c895311991f2a4a2deb9436b220cc0',
     armv7l: '86d5a6f17c1221eb24c2802342c2645074c895311991f2a4a2deb9436b220cc0',
       i686: '3b902fb63708c219f8e5cede9b24fee5641899611b294ee4e391f578489fa41c',
     x86_64: '3edff660a6693a9245e7e9fa2bd4a4cf890b993f0ed3b3b4fef42484fba34b2d'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'autoconf213' => :build
  depends_on 'graphviz'
  depends_on 'libxslt'
  depends_on 'glib'
  depends_on 'dbus'
  git_fetchtags
  gnome

  def self.build
    # Bootstrap vala
    FileUtils.mkdir_p 'bootstrap_install'
    system 'git clone https://gitlab.gnome.org/Archive/vala-bootstrap.git'
    Dir.chdir('vala-bootstrap') do
      system 'git checkout b2beeaccdf2307ced172646c2ada9765e1747b28'
      system 'touch */*.stamp'
      system 'autoreconf -fi'
      system 'VALAC=/no-valac ./configure --prefix=`pwd`/../bootstrap_install'
      system 'mold -run make'
      system 'make install'
    end

    system "#{CREW_ENV_OPTIONS} VALAC=`pwd`/bootstrap_install/bin/valac ./autogen.sh \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --disable-valadoc"
    system 'mold -run make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
