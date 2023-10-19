require 'package'

class Geany < Package
  description 'Geany is a small and lightweight Integrated Development Environment.'
  homepage 'https://www.geany.org/'
  version '2.0.0'
  license 'GPL-2+ HPND'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/geany/geany.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/2.0.0_armv7l/geany-2.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/2.0.0_armv7l/geany-2.0.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/2.0.0_x86_64/geany-2.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8be66872a26db0399da46595609f6bda991a7b9a4594413685a5f82916435b75',
     armv7l: '8be66872a26db0399da46595609f6bda991a7b9a4594413685a5f82916435b75',
     x86_64: '58b0273c68e563ace1099b64f143e0b7029d6930ab84819ea18e01902ad8f1f8'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'vte' # L
  depends_on 'xdg_base' # L

  @xdg_config_home = ENV.fetch('XDG_CONFIG_HOME', nil)
  @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?

  def self.build
    system "mold -run meson setup \
      #{CREW_MESON_OPTIONS} \
      -Dapi-docs=disabled \
      -Dgtkdoc=true \
      -Dhtml-docs=disabled \
      -Dpdf-docs=disabled \
      -Dplugins=true \
      -Dpython-command=command=$(which python3) \
      -Dsocket=true \
      -Dvte=true \
      builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.check
    # Fails on armv7l
    # Bail out! dbind-FATAL-WARNING: Couldn't connect to accessibility bus: Failed to connect to socket /var/run/chrome/at-spi/buscheekon_10.0: No such file or directory
    system "#{CREW_NINJA} -C builddir test || true"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.postinstall
    # This is needed to avoid "Error loading theme icon 'geany-build' for stock" messages.
    system "gtk-update-icon-cache #{CREW_PREFIX}/share/icons/hicolor -f"
  end

  def self.remove
    config_dirs = ["#{HOME}/.config/geany", "#{@xdg_config_home}/geany"]
    config_dirs.each do |config_dir|
      next unless Dir.exist? config_dir

      print "\nWould you like to remove #{config_dir}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
