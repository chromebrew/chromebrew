require 'package'

class Glibmm < Package
  description "C++ bindings for GLib"
  homepage "https://www.gtkmm.org"
  version "2.64.2"
  compatibility "all"
  source_url "https://ftp.gnome.org/pub/GNOME/sources/glibmm/2.64/glibmm-2.64.2.tar.xz"
  source_sha256 "a75282e58d556d9b2bb44262b6f5fb76c824ac46a25a06f527108bec86b8d4ec"

  depends_on "libsigcplusplus"
  depends_on 'mm_common' => :build

  def self.build
      system "./configure #{CREW_OPTIONS} "
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
