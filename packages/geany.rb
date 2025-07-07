require 'buildsystems/meson'

class Geany < Meson
  description 'Geany is a small and lightweight Integrated Development Environment.'
  homepage 'https://www.geany.org/'
  version '2.1.0'
  license 'GPL-2+ HPND'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/geany/geany.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8be66872a26db0399da46595609f6bda991a7b9a4594413685a5f82916435b75',
     armv7l: '8be66872a26db0399da46595609f6bda991a7b9a4594413685a5f82916435b75',
     x86_64: '5b791ec438f7940734d0fbdcc1c87349f35d6b2a478b2bf3e3d5a8103a9db2c4'
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

  meson_options "-Dapi-docs=disabled \
      -Dgtkdoc=true \
      -Dhtml-docs=disabled \
      -Dpdf-docs=disabled \
      -Dplugins=true \
      -Dpython-command=command=$(which python3) \
      -Dsocket=true \
      -Dvte=true"

  def self.postinstall
    # This is needed to avoid "Error loading theme icon 'geany-build' for stock" messages.
    system "gtk-update-icon-cache #{CREW_PREFIX}/share/icons/hicolor -f"
  end

  def self.postremove
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
