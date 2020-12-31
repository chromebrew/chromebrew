require 'package'

class Homebank < Package
  description 'HomeBank is a free software that will assist you to manage your personal accounting.'
  homepage 'http://homebank.free.fr/en/index.php'
  version '5.4.3'
  compatibility 'all'
  source_url "http://homebank.free.fr/public/homebank-#{version}.tar.gz"
  source_sha256 '79a89ab8816a5973fa6afe75157fa375953795c79c224d510e8af0afed2512d2'

  depends_on 'libofx'
  depends_on 'libsoup'
  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'wayland_protocols'
  depends_on 'mesa'
  depends_on 'xcb_util'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mv '#{CREW_DEST_PREFIX}/bin/homebank', '#{CREW_DEST_PREFIX}/bin/homebank_orig'
    system "cat <<'EOF'> homebank
WAYLAND_DISPLAY=wayland-0
GDK_BACKEND=wayland
DISPLAY=
#{CREW_PREFIX}/bin/homebank_orig $@
EOF"
    system "install -Dm755 homebank #{CREW_DEST_PREFIX}/bin/homebank"
  end
end
