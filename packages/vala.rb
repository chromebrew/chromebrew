require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.56.7'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/vala.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.56.7_armv7l/vala-0.56.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.56.7_armv7l/vala-0.56.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.56.7_i686/vala-0.56.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vala/0.56.7_x86_64/vala-0.56.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4987cd9bdffb4056e046e81e11600bd7eb38085ce76fc87822b20be2b31aeba6',
     armv7l: '4987cd9bdffb4056e046e81e11600bd7eb38085ce76fc87822b20be2b31aeba6',
       i686: '794bcb3f8b6d1f2e6cbb6b4ad0029dfabbc00a2c830df13c5939d06c6afb93ab',
     x86_64: '55f786136cccd4bc28ed2f28056a09c143fe5acd2d1af6d08fe80bd228e725a2'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'autoconf213' => :build
  depends_on 'graphviz' unless ARCH.eql?('i686')
  depends_on 'libxslt'
  depends_on 'glib'
  depends_on 'dbus'
  depends_on 'glibc' # R

  git_fetchtags

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
