require 'package'

class Flatpak < Package
  description 'Flatpak is a system for building, distributing, and running sandboxed desktop applications on Linux.'
  homepage 'https://flatpak.org'
  @_ver = '1.10.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/flatpak/flatpak/releases/download/#{@_ver}/flatpak-#{@_ver}.tar.xz"
  source_sha256 'c70215792b7cbece83c489dab86adc9bfaf9b140c506affe2a48c92afa3d69b7'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6927a9717a15f4d52e1b2316e159a2f43026431bc91a68627bc6fce5f9634b31',
     armv7l: '6927a9717a15f4d52e1b2316e159a2f43026431bc91a68627bc6fce5f9634b31',
       i686: '56abe90a29219a9937b2939a71b4413d90198d7eabc1cb802b3fc6a759a93335',
     x86_64: '588c3a2c502e0cc6088b4d17e3b133103fdeb0dc653bad0bef79674709b7bf22'
  })

  depends_on 'xdg_base'
  depends_on 'bubblewrap'
  depends_on 'libostree'
  depends_on 'polkit'
  depends_on 'appstream_glib'
  depends_on 'libseccomp'
  depends_on 'pyparsing'
  depends_on 'dconf'
  depends_on 'pulseaudio'

  def self.patch
    patch_description = 'backported fixes'
    patch_url = 'https://patch-diff.githubusercontent.com/raw/flatpak/flatpak/pull/4132.patch'
    patch_sha256 = '8230491be909a027fdb5a03ff0fa638331c940289fa6d68a21489d78c6f7f6b0'
    patch_filename = 'patch'
    puts "Downloading patch: #{patch_description}".yellow
    system('curl', '-s', '--insecure', '-L', '-#', patch_url, '-o', patch_filename)
    abort 'Checksum mismatch. :/ Try again.'.lightred unless
    Digest::SHA256.hexdigest(File.read(patch_filename)) == patch_sha256
    puts 'patch downloaded'.lightgreen
    system 'patch  -p 1 --forward < patch || true'
  end

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env BWRAP=#{CREW_PREFIX}/bin/bwrap CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
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
  end

  def self.postinstall
    puts
    puts 'Configuring flathub'.lightblue
    system 'flatpak.elf remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo'
    puts
    # Check to see if xdg_base put variables in ~/.bashrc. If not, put
    # them in.
    xdgbaseconfig_in_bashrc = `grep -c "XDG_CONFIG_HOME" ~/.bashrc || true`
    unless xdgbaseconfig_in_bashrc.to_i.positive?
      puts 'Putting XDG Environment Variables in ~/.bashrc'.lightblue
      system "echo '# XDG Base Directory Specification Environment Variables' >> ~/.bashrc"
      system "echo '# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html' >> ~/.bashrc"
      system "echo 'export XDG_DATA_HOME=#{HOME}/.local/share' >> ~/.bashrc"
      system "echo 'export XDG_CONFIG_HOME=#{HOME}/.config' >> ~/.bashrc"
      system "echo 'export XDG_DATA_DIRS=#{CREW_PREFIX}/share:#{HOME}/.local/share/flatpak/exports/share:#{CREW_PREFIX}/var/lib/flatpak/exports/share' >> ~/.bashrc"
      system "echo 'export XDG_CONFIG_DIRS=#{CREW_PREFIX}/etc/xdg' >> ~/.bashrc"
      system "echo 'export XDG_CACHE_HOME=#{HOME}/.cache' >> ~/.bashrc"
      system "echo 'export XDG_RUNTIME_DIR=/var/run/chrome' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
    # If xdg_base put in variables without flatpak modifications, add
    # them.
    flatpak_xdgdirconfig_in_bashrc = `grep -c "#{CREW_PREFIX}/var/lib/flatpak/exports/share" ~/.bashrc || true`
    unless flatpak_xdgdirconfig_in_bashrc.to_i.positive?
      system "sed -i 's,XDG_DATA_DIRS=.*,XDG_DATA_DIRS=#{CREW_PREFIX}/share:#{HOME}/.local/share/flatpak/exports/share:#{CREW_PREFIX}/var/lib/flatpak/exports/share,g' ~/.bashrc"
    end
  end
end
