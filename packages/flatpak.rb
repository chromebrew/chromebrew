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
    aarch64: 'ee4cf9fe437d1aa7b6804d0b323c81c9df25cd14a6124bc5d624ad3238df6875',
     armv7l: 'ee4cf9fe437d1aa7b6804d0b323c81c9df25cd14a6124bc5d624ad3238df6875',
       i686: '6cfa3ece1b485369f16fb62c5b17744d56a7aa162a95aab49d3d9663026cbd60',
     x86_64: 'ac8e6a92a18862201c12563036f206804547d2a1d350f548d130bb38b9dfea5b'
  })

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
  end

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env BWRAP=#{CREW_PREFIX}/bin/bwrap CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-system-install-dir=#{CREW_PREFIX}/var/lib/flatpak \
      --enable-sandboxed-triggers \
      --with-priv-mode=none \
      --enable-san \
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
      unset GDK_PIXBUF_MODULE_FILE
      unset GDK_PIXBUF_MODULEDIR
      unset GDK_BACKEND
      unset FONTCONFIG_PATH
      #{CREW_PREFIX}/bin/flatpak.elf "\$@"
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
