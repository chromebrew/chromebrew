require 'buildsystems/autotools'

class Pidgin < Autotools
  description 'Pidgin is a chat program which lets you log in to accounts on multiple chat networks simultaneously.'
  homepage 'https://pidgin.im/'
  version '2.14.14'
  license 'GPL-2'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://prdownloads.sourceforge.net/project/pidgin/Pidgin/#{version}/pidgin-#{version}.tar.bz2"
  source_sha256 '0ffc9994def10260f98a55cd132deefa8dc4a9835451cc0e982747bd458e2356'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c69f235347be1d0200af259304853f61b52d618df109cf155ba1b024c54b8298',
     armv7l: 'c69f235347be1d0200af259304853f61b52d618df109cf155ba1b024c54b8298',
       i686: '599c537f43a41ed36981d07c459a19f29806cfaf13b5cc14f7230f95a77c8876',
     x86_64: 'f1dd2f45e3c07f4a880e476bb57cd05622b33bc900dd3570ae81643db36328e5'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'e2fsprogs' # R
  depends_on 'evolution_data_server'
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'gstreamer'
  depends_on 'gtk2'
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libgconf'
  depends_on 'libice' # R
  depends_on 'libidn2'
  depends_on 'libsm' # R
  depends_on 'libsoup' # R
  depends_on 'libtirpc' # R
  depends_on 'libx11' # R
  depends_on 'libxcrypt' # R
  depends_on 'libxml2' # R
  depends_on 'nss' # R
  depends_on 'pango' # R
  depends_on 'perl' # R
  depends_on 'sommelier' => :logical

  def self.patch
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' configure"
  end

  autotools_configure_options "--disable-avahi \
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

  def self.postremove
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
