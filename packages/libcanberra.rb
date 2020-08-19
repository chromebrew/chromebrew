require 'package'

class Libcanberra < Package
    description "XDG Sound Theme and Name Specification library implementation"
    homepage "http://0pointer.de/lennart/projects/libcanberra/"
    version "0.30"
    compatibility "all"
    source_url "http://pkgs.fedoraproject.org/repo/pkgs/libcanberra/libcanberra-0.30.tar.xz/34cb7e4430afaf6f447c4ebdb9b42072/libcanberra-0.30.tar.xz"
    source_sha256 "c2b671e67e0c288a69fc33dc1b6f1b534d07882c2aceed37004bf48c601afa72"

    depends_on "pygtk"
    depends_on "libvorbis"
    depends_on "libtool"
    depends_on "gstreamer"
    depends_on "alsa_lib"
    depends_on "tdb"
    depends_on "pulseaudio"
    depends_on "eudev"
    depends_on "vala"

    def self.build
        system "./configure #{CREW_OPTIONS} --enable-alsa --enable-null --disable-lynx --enable-gstreamer --disable-oss --with-builtin=dso"
        system "make -j#{CREW_NPROC}"
    end
    def self.install
        system "make install DESTDIR=#{CREW_DEST_DIR}"
    end
end