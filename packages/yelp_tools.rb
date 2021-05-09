require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://wiki.gnome.org/Apps/Yelp/Tools/'
  @_ver = '40.0'
  version @_ver + '-1'
  license 'GPL-2+ or freedist and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/yelp-tools.git'
  git_hashtag @_ver

  depends_on 'yelp_xsl'
  depends_on 'libxslt'
  depends_on 'py3_lxml'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
