require 'package'

class Geany < Package
  description 'Geany is a small and lightweight Integrated Development Environment.'
  homepage 'https://www.geany.org/'
  version '22aac44'
  license 'GPL-2+ HPND'
  compatibility 'all'
  source_url 'https://github.com/geany/geany.git'
  git_hashtag '22aac4436da749d69aa1b330feb517ad0a4bac74'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/22aac44_armv7l/geany-22aac44-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/22aac44_armv7l/geany-22aac44-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/22aac44_i686/geany-22aac44-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/22aac44_x86_64/geany-22aac44-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '43991696a7789093b8bf08097c993f5f8454e056208839ffb33f80313f300ab3',
     armv7l: '43991696a7789093b8bf08097c993f5f8454e056208839ffb33f80313f300ab3',
       i686: 'e0fd6c90f33e0a193085a6fc40dd6fcbb7ba93895654af8081cf3099e9a3ee80',
     x86_64: 'dd80c365678847a11d7cd2c2b1dcc9d6d88b50fa573a895d506555113ea973d7'
  })

  depends_on 'atk_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'sommelier'
  depends_on 'vte'
  depends_on 'xdg_base'

  @xdg_config_home = ENV.fetch('XDG_CONFIG_HOME', nil)
  @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure \
      #{CREW_OPTIONS} \
      --enable-api-docs=no \
      --enable-html-docs=no \
      --enable-pdf-docs=no"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
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
