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
    aarch64: '80704831036697f5d42a8e2a9127d19ced5c093d63ac22cf491a7f34f6cd6b1c',
     armv7l: '80704831036697f5d42a8e2a9127d19ced5c093d63ac22cf491a7f34f6cd6b1c',
       i686: 'e813314e321e7f2b4cfe01aa058e9d9f554581af0c4ace8487a3082127b939da',
     x86_64: '7aa8e4200d9a8553d0055ecb4bcbc1621bb1d0ae9e16b4cd456233e1360d7058'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'autoconf213' => :build
  depends_on 'graphviz'
  depends_on 'libxslt'
  depends_on 'glib'
  depends_on 'dbus'
  depends_on 'glibc' # R
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
