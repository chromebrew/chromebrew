require 'package'

class Flatpak < Package
  description 'Flatpak is a system for building, distributing, and running sandboxed desktop applications on Linux.'
  homepage 'https://flatpak.org'
  @_ver = '1.10.2'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/flatpak/flatpak/releases/download/#{@_ver}/flatpak-#{@_ver}.tar.xz"
  source_sha256 'db152739d072f8ff299e4e888d8963a1b4538da7b10e0b86525be438f2e1dde4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c75d3704f54b035af47b13aec034e762f55ef01de3193f9948af9c2f94240160',
     armv7l: 'c75d3704f54b035af47b13aec034e762f55ef01de3193f9948af9c2f94240160',
       i686: '5d379657448f6186f23ed5e47ccebbfc1e5b03ad930886c093451b32f0734390',
     x86_64: '6b35bbf60cc693be3dd808dd697d0a5d62cbe2f830d6a856fa32aa1e15d7210b'
  })

  depends_on 'appstream_glib'
  depends_on 'bubblewrap'
  depends_on 'dconf'
  depends_on 'libevent'
  depends_on 'libostree'
  depends_on 'libsoup2'
  depends_on 'polkit'
  depends_on 'pulseaudio'
  depends_on 'pyparsing'
  depends_on 'xdg_base'

  def self.patch
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
    system "env BWRAP=#{CREW_PREFIX}/bin/bwrap CFLAGS='-flto=auto' \
      CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-system-install-dir=#{CREW_PREFIX}/var/lib/flatpak \
      --enable-sandboxed-triggers \
      --with-priv-mode=none \
      --without-systemd \
      --with-system-fonts-dir=#{CREW_PREFIX}/share/fonts:/usr/share/fonts \
      --with-system-font-cache-dirs=/usr/share/cache/fontconfig:#{CREW_PREFIX}/cache/fontconfig \
      --disable-documentation \
      --disable-maintainer-mode \
      --with-system-bubblewrap"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/flatpak", "#{CREW_DEST_PREFIX}/bin/flatpak.elf", mode: 0o755
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
      #{CREW_PREFIX}/bin/flatpak.elf \$FLATPAK_FLAGS  "\$@"
    FLATPAK_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/bin/flatpak", @flatpak_sh, perm: 0o755)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dbus-1/system.d"
    FileUtils.mv "#{CREW_DEST_PREFIX}/etc/dbus-1/system.d/org.freedesktop.Flatpak.SystemHelper.conf",
                 "#{CREW_DEST_PREFIX}/share/dbus-1/system.d/org.freedesktop.Flatpak.SystemHelper.conf"
  end

  def self.postinstall
    puts
    puts 'Configuring flathub'.lightblue
    system 'flatpak.elf remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo'
    puts
    # Check to see if XDG_DATA_DIRS for flatpak is in ~/.bashrc. If not, put
    # it in.
    @_str = "XDG_DATA_DIRS=#{CREW_PREFIX}/share:#{CREW_PREFIX}/.config/.local/share/flatpak/exports/share:#{CREW_PREFIX}/var/lib/flatpak/exports/share"
    if `grep -c '#{@_str}' #{HOME}/.bashrc`.to_i.zero?
      puts 'Putting XDG Environment Variables in ~/.bashrc'.lightblue
      system "sed -i '/XDG_DATA_DIRS/d' ~/.bashrc"
      system "echo 'export XDG_DATA_DIRS=#{CREW_PREFIX}/share:#{CREW_PREFIX}/.config/.local/share/flatpak/exports/share:#{CREW_PREFIX}/var/lib/flatpak/exports/share' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
  end
end
