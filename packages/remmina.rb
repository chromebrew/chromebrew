require 'package'

class Remmina < Package
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.31'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'x86_64'
  source_url "https://gitlab.com/Remmina/Remmina/-/archive/v#{version}/Remmina-v#{version}.tar.bz2"
  source_sha256 'cfe9d4a6f2951d35533e5b2235f76640573c91f1be3bd8118637fbf68234500a'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remmina/1.4.31_x86_64/remmina-1.4.31-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '7d8d2fc596ce07b395c1436507814632aee72692cfb54592a9a4f88fb24ab8a4'
  })

  depends_on 'avahi' # L
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'freerdp' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libappindicator_gtk3' # R
  depends_on 'libgcrypt' # R
  depends_on 'libsecret' # R
  depends_on 'libsodium' # R
  depends_on 'libsoup' # R
  depends_on 'libssh' # R
  depends_on 'libvncserver' # R
  depends_on 'openssl' # R
  depends_on 'pango' # R
  depends_on 'python3' # R
  depends_on 'sommelier' # L
  depends_on 'spice_gtk' => :build
  depends_on 'vte' # R
  depends_on 'wayland' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'xdg_utils' => :build

  def self.build
    system "cmake -B builddir \
      -G Ninja \
      #{CREW_CMAKE_OPTIONS.sub("C_FLAGS='",
                               "C_FLAGS='-Wno-unused-function ")} \
      -DWITH_TELEPATHY=OFF"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
