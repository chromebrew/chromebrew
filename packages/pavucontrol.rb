require 'package'

class Pavucontrol < Package
  description 'PulseAudio Volume Control'
  homepage 'https://freedesktop.org/software/pulseaudio/pavucontrol/'
  version '4.0'
  compatibility 'all'
  source_url 'https://freedesktop.org/software/pulseaudio/pavucontrol//pavucontrol-4.0.tar.xz'
  source_sha256 '8fc45bac9722aefa6f022999cbb76242d143c31b314e2dbb38f034f4069d14e2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '97f4ff801cdca8a12c665e5d1467e1749f06803fb7f2ac4423be95c057fc8e13',
     armv7l: '97f4ff801cdca8a12c665e5d1467e1749f06803fb7f2ac4423be95c057fc8e13',
       i686: '1b536d2c99e5466a4939b82b25cd94f105ce2ca24cece37f868df3bc30078496',
     x86_64: '91919320ed61fdc26730f8a7d1d19dbc712b158b16ddd2de4d77ad029b461b52',
  })

  depends_on 'gtkmm2'
  depends_on 'gtkmm3'
  depends_on 'libcanberra'
  depends_on 'pygtk'
  depends_on 'pulseaudio'
  depends_on 'glibmm'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC} -lgtkmm-3.24" # Issue with gtkmm - gtk::builder
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
