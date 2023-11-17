require 'buildsystems/meson'

class Flatpak < Meson
  description 'Flatpak is a system for building, distributing, and running sandboxed desktop applications on Linux.'
  homepage 'https://flatpak.org'
  version '1.15.6'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/flatpak/flatpak.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatpak/1.15.6_armv7l/flatpak-1.15.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatpak/1.15.6_armv7l/flatpak-1.15.6-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flatpak/1.15.6_x86_64/flatpak-1.15.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '313ff8ecaf84a2a42d24bde5999d6ec455dda6694d734973cb4c226b510241d9',
     armv7l: '313ff8ecaf84a2a42d24bde5999d6ec455dda6694d734973cb4c226b510241d9',
     x86_64: '205159d142b8fb7c9a65ac75309d4391889af4afc2dbd56e79da692b18c93e32'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'appstream' # R
  depends_on 'bubblewrap' # L
  depends_on 'curl' # R
  depends_on 'dconf' # R
  depends_on 'fuse3' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gpgme' # R
  depends_on 'json_glib' # R
  depends_on 'libarchive' # R
  depends_on 'libassuan' => :build
  depends_on 'libevent' => :build
  depends_on 'libostree' # R
  depends_on 'libseccomp' # R
  depends_on 'libsoup2' => :build
  depends_on 'libxau' # R
  depends_on 'libxml2' # R
  depends_on 'polkit' => :build
  depends_on 'pulseaudio' => :build
  depends_on 'py3_pyparsing' => :build
  depends_on 'socat' # L
  depends_on 'wayland' # R
  depends_on 'xdg_base' => :build
  depends_on 'xdg_dbus_proxy' => :build
  depends_on 'xmlto' => :build
  depends_on 'zstd' # R

  meson_options "-Dsystem_install_dir=#{CREW_PREFIX}/var/lib/flatpak \
              -Dsystemd=disabled \
              -Dsystem_bubblewrap=#{CREW_PREFIX}/bin/bwrap \
              -Dsystem_fonts_dir=#{CREW_PREFIX}/share/fonts:/usr/share/fonts \
              -Dsystem_font_cache_dirs=#{CREW_PREFIX}/cache/fontconfig:/usr/share/cache/fontconfig \
              -Dsystem_helper=disabled \
              -Dtests=false"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
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
      if [[ "$*" == *run* ]]
      then
          FLATPAK_FLAGS='--socket=wayland'
      else
          FLATPAK_FLAGS='--user'
      fi
      unset GDK_PIXBUF_MODULE_FILE
      unset GDK_PIXBUF_MODULEDIR
      unset GDK_BACKEND
      unset FONTCONFIG_PATH
      #{CREW_PREFIX}/libexec/flatpak/flatpak $FLATPAK_FLAGS  "$@"
    FLATPAK_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/bin/flatpak", @flatpak_sh, perm: 0o755)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~FLATPAK_ENVD_EOF
      # Flatpak configuration
      export XDG_DATA_DIRS='#{CREW_PREFIX}/share:#{CREW_PREFIX}/.config/.local/share/flatpak/exports/share:#{CREW_PREFIX}/var/lib/flatpak/exports/share'
    FLATPAK_ENVD_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/flatpak", @env)
  end

  def self.postinstall
    puts "Please run 'crew postinstall flatpak' from VT-2 to complete the install.".lightblue
    system '[ -e /var/run/chrome/dconf ] || sudo mkdir /var/run/chrome/dconf', exception: false
    system 'sudo chown chronos:chronos /var/run/chrome/dconf/ -Rv', exception: false
    puts
    puts 'Configuring flathub'.lightblue
    system "#{CREW_PREFIX}/libexec/flatpak/flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo", exception: false
    puts
  end
end
