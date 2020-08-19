require 'package'

class Pavucontrol < Package
    description "PulseAudio Volume Control"
    homepage "https://freedesktop.org/software/pulseaudio/pavucontrol/"
    version "4.0"
    compatibility "all"
    source_url "https://freedesktop.org/software/pulseaudio/pavucontrol//pavucontrol-4.0.tar.xz"
    source_sha256 "8fc45bac9722aefa6f022999cbb76242d143c31b314e2dbb38f034f4069d14e2"

    depends_on "gtkmm2"
    depends_on "gtkmm3"
    depends_on "libcanberra"
    depends_on "pygtk"
    depends_on "pulseaudio"
    depends_on "glibmm"
    
    def self.build
        system "./configure #{CREW_OPTIONS}"
        system "make -j#{CREW_NPROC} -lgtkmm-3.24" # Issue with gtkmm - gtk::builder
    end
    def self.install
        system "make install DESTDIR=#{CREW_DEST_DIR}"
    end
end
