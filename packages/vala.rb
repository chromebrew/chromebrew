require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.56.16'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/vala.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0780c098de6f9a613c2c963e390bcebb5bea73222c345874e62fb4f761bafad',
     armv7l: 'b0780c098de6f9a613c2c963e390bcebb5bea73222c345874e62fb4f761bafad',
     x86_64: '58f591a559ad11aa772e3107191136c6c4895ca9372fb917a0f22536acd45401'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'autoconf213' => :build
  depends_on 'graphviz' => :build
  depends_on 'libxslt' => :build
  depends_on 'glib' => :build
  depends_on 'dbus' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R

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
      system "VALAC=/no-valac mold -run ./configure --prefix=#{Dir.pwd}/../bootstrap_install"
      system 'make'
      system 'make install'
    end

    system "VALAC=#{Dir.pwd}/bootstrap_install/bin/valac mold -run ./autogen.sh \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --disable-valadoc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
