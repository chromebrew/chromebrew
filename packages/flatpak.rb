require 'package'

class Flatpak < Package
  description 'Flatpak is a system for building, distributing, and running sandboxed desktop applications on Linux.'
  homepage 'https://flatpak.org'
  version '1.10.2'
  revision 1
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/flatpak/flatpak/releases/download/#{version}/flatpak-#{version}.tar.xz"
  source_sha256 'db152739d072f8ff299e4e888d8963a1b4538da7b10e0b86525be438f2e1dde4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatpak/1.10.2-1_armv7l/flatpak-1.10.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatpak/1.10.2-1_armv7l/flatpak-1.10.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatpak/1.10.2-1_i686/flatpak-1.10.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatpak/1.10.2-1_x86_64/flatpak-1.10.2-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f03b38526bd4874d0e917bac2e743929f8e118ab67796ee088f36e4712d4c35b',
     armv7l: 'f03b38526bd4874d0e917bac2e743929f8e118ab67796ee088f36e4712d4c35b',
       i686: 'cd76a117df4c1757410dda6f17ac5d1a46a0028ab3116ae3fea5af602774a1d4',
     x86_64: 'ae83c2515abec6eb9969b69d838280f70f620f51ad21231ce5e297c87f5cff5c'
  })

  depends_on 'appstream_glib'
  depends_on 'bubblewrap'
  depends_on 'dconf'
  depends_on 'fuse2'
  depends_on 'gdk_pixbuf'
  depends_on 'gpgme'
  depends_on 'json_glib'
  depends_on 'libarchive'
  depends_on 'libassuan'
  depends_on 'libevent'
  depends_on 'libostree'
  depends_on 'libsoup2'
  depends_on 'libxau'
  depends_on 'polkit'
  depends_on 'pulseaudio'
  depends_on 'py3_pyparsing'
  depends_on 'xdg_base'
  depends_on 'xdg_dbus_proxy'
  depends_on 'xmlto' => :build

  def self.patch
    # Use fuse3
    # system "sed -i 's:PKG_CHECK_MODULES(FUSE, fuse >= 2.9.2):PKG_CHECK_MODULES(FUSE, fuse3 >= 3.1.1):' configure.ac"
    # system "sed -i 's:#define FUSE_USE_VERSION 26:#define FUSE_USE_VERSION 31:' revokefs/main.c"

    # Source has libglnx repo as submodule
    @git_dir = 'libglnx'
    @git_hash = '4c9055ac08bb64dca146724f488cce4c1ce4c628'
    @git_url = 'https://gitlab.gnome.org/GNOME/libglnx.git'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
    # Source has bubblewrap repo as submodule
    @git_dir = 'bubblewrap'
    @git_hash = 'e1b11e65929f425815f2924489d3fefd453dedd9'
    @git_url = 'https://github.com/containers/bubblewrap.git'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
    # Source has variant-schema-compiler repo as submodule
    @git_dir = 'variant-schema-compiler'
    @git_hash = 'd9af1f4324d912634216d69118100583fc1dcd26'
    @git_url = 'https://gitlab.gnome.org/alexl/variant-schema-compiler.git'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
  end

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env BWRAP=#{CREW_PREFIX}/bin/bwrap \
              CFLAGS='-pipe -flto=auto -fuse-ld=gold' \
              CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
              LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS} \
              --with-system-install-dir=#{CREW_PREFIX}/var/lib/flatpak \
              --localstatedir=#{CREW_PREFIX}/var \
              --enable-sandboxed-triggers \
              --with-priv-mode=none \
              --without-systemd \
              --with-system-fonts-dir=#{CREW_PREFIX}/share/fonts:/usr/share/fonts \
              --with-system-font-cache-dirs=/usr/share/cache/fontconfig:#{CREW_PREFIX}/cache/fontconfig \
              --disable-documentation \
              --disable-maintainer-mode \
              --enable-xauth \
              --with-system-dbus-proxy \
              --with-system-bubblewrap"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/libexec/flatpak/"
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/flatpak", "#{CREW_DEST_PREFIX}/libexec/flatpak/flatpak", mode: 0o755
    @flatpak_sh = <<~FLATPAK_HEREDOC
      #!/bin/bash
      # Flatpak needs to be able to see fonts in #{CREW_PREFIX}/share/fonts
      if [ -L "~/.local/share/fonts" ] && [ ! -e "~/.local/share/fonts" ]; then
      rm -f ~/.local/share/fonts
      fi
      if [ !  \\( -e ~/.local/share/fonts \\)  ]; then
      ln -s #{CREW_PREFIX}/share/fonts ~/.local/share/
      fi
      # Start pulseaudio if it is not running.
      pgrep -x pulseaudio >/dev/null || pulseaudio -D
      if [[ "\$*" == *run* ]]
      then
          FLATPAK_FLAGS='--socket=wayland'
      else
          FLATPAK_FLAGS='--user'
      fi
      unset GDK_PIXBUF_MODULE_FILE
      unset GDK_PIXBUF_MODULEDIR
      unset GDK_BACKEND
      unset FONTCONFIG_PATH
      #{CREW_PREFIX}/libexec/flatpak/flatpak \$FLATPAK_FLAGS  "\$@"
    FLATPAK_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/bin/flatpak", @flatpak_sh, perm: 0o755)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dbus-1/system.d"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/dbus-1/system.d/org.freedesktop.Flatpak.SystemHelper.conf",
                 "#{CREW_DEST_PREFIX}/share/dbus-1/system.d/org.freedesktop.Flatpak.SystemHelper.conf"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Flatpak configuration
      export XDG_DATA_DIRS='#{CREW_PREFIX}/share:#{CREW_PREFIX}/.config/.local/share/flatpak/exports/share:#{CREW_PREFIX}/var/lib/flatpak/exports/share'
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/flatpak", @env)
  end

  def self.postinstall
    system '[ -e /var/run/chrome/dconf ] || sudo mkdir /var/run/chrome/dconf'
    system 'sudo chown chronos:chronos /var/run/chrome/dconf/ -Rv'
    puts
    puts 'Configuring flathub'.lightblue
    system "#{CREW_PREFIX}/libexec/flatpak/flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo"
    puts
  end
end
