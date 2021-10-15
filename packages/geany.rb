require 'package'

class Geany < Package
  description 'Geany is a small and lightweight Integrated Development Environment.'
  homepage 'https://www.geany.org/'
  version '1.38.0'
  license 'GPL-2+ HPND'
  compatibility 'all'
  source_url 'https://github.com/geany/geany.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.38.0_armv7l/geany-1.38.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.38.0_armv7l/geany-1.38.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.38.0_i686/geany-1.38.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.38.0_x86_64/geany-1.38.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5171072c5f06a83470f05b717f4920670e096401476bd75da529f3ae6c2a2eed',
     armv7l: '5171072c5f06a83470f05b717f4920670e096401476bd75da529f3ae6c2a2eed',
       i686: 'ff04fdbe592f3de51138d98f1c1886fa1535625dae9caa8bd8cb147c8e29774a',
     x86_64: 'af37717e4484a5fbed7755961cbacebbe8e7e4abfd352ac26d01a33a2b989aba'
  })

  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'sommelier'
  depends_on 'vte'

  @xdg_config_home = ENV['XDG_CONFIG_HOME']
  @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} \
      ./configure \
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
      case $stdin.getc
      when 'y', 'Y'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
