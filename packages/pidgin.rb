require 'buildsystems/autotools'

class Pidgin < Autotools
  description 'Pidgin is a chat program which lets you log in to accounts on multiple chat networks simultaneously.'
  homepage 'https://pidgin.im/'
  version '2.14.13'
  license 'GPL-2'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://prdownloads.sourceforge.net/project/pidgin/Pidgin/#{version}/pidgin-#{version}.tar.bz2"
  source_sha256 '120049dc8e17e09a2a7d256aff2191ff8491abb840c8c7eb319a161e2df16ba8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c69f235347be1d0200af259304853f61b52d618df109cf155ba1b024c54b8298',
     armv7l: 'c69f235347be1d0200af259304853f61b52d618df109cf155ba1b024c54b8298',
       i686: '599c537f43a41ed36981d07c459a19f29806cfaf13b5cc14f7230f95a77c8876',
     x86_64: 'affbeee4dd0f27f84ba07d06c119afeb6fb41294f82e2de9a562f137fa31943a'
  })

  depends_on 'evolution_data_server'
  depends_on 'glib'
  depends_on 'gstreamer'
  depends_on 'gtk2'
  depends_on 'libgconf'
  depends_on 'libidn2'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' configure"
  end

  configure_options "--disable-avahi \
    --disable-dbus \
    --disable-gtkspell \
    --disable-idn \
    --disable-meanwhile \
    --disable-screensaver \
    --disable-tcl \
    --disable-tk \
    --disable-vv \
    --enable-consoleui=no \
    --includedir=#{CREW_PREFIX}/include \
    --oldincludedir=#{CREW_PREFIX}/include \
    --with-tclconfig=#{CREW_LIB_PREFIX} \
    --libdir=#{CREW_LIB_PREFIX} \
    --with-x"

  def self.remove
    config_dir = "#{HOME}/.purple"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
