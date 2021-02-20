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
    aarch64: '7f5e0963404adecb152f78d1cfe927ddafd51922457c915aba085273b018bf5a',
     armv7l: '7f5e0963404adecb152f78d1cfe927ddafd51922457c915aba085273b018bf5a',
       i686: '8f6f7db757c93f62b52effdc7e2460d19a59737714465fe66f60d8510a22ec5e',
     x86_64: '49db0379a744d5e8dca87f480a2c4754bda7890629a4a5da7d6e8cccd8c88660'
  })

  depends_on 'xdg_base'
  depends_on 'bubblewrap'
  depends_on 'libostree'
  depends_on 'polkit'
  depends_on 'appstream_glib'
  depends_on 'libseccomp'
  depends_on 'pyparsing'
  depends_on 'dconf'

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
      if [[ "\$*" == *run* ]]
      then
          FLATPAK_FLAGS='--socket=wayland'
      else
          FLATPAK_FLAGS=''
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
    system 'flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo'
    puts
  end
end
