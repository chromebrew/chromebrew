require 'package'

class Libxml2_python < Package
  description 'Libxml2 (python module) is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.10-f93c'
  compatibility 'all'
  source_url 'https://github.com/GNOME/libxml2/archive/f93ca3e140a371b26366f747a408588c631e0fd1.zip'
  source_sha256 '0faa7455354a724e3d07c37177cbf125b3e04da91073fa0858806cb5376f2c55'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.10-f93c-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.10-f93c-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.10-f93c-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.10-f93c-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'a9a5e98c5efbaa2640f4d6b89c5bbe790c1f4b76c5eb27796c3f3fed4746f4d1',
      armv7l: 'a9a5e98c5efbaa2640f4d6b89c5bbe790c1f4b76c5eb27796c3f3fed4746f4d1',
        i686: 'e33618cc4ec9f4a0a6ee1f2a27de1a137981bb2beb6158fd6dc988bd2821d0be',
      x86_64: '1cdba7d1e69a31876eabab8f84f61a883486140a9acc09f57c2f9ed27a3f912f',
  })

  depends_on 'libxslt'

  def self.build
    system "autoreconf -fi"
    system "./configure #{CREW_OPTIONS}"
    Dir.chdir("python") do
      system "LDFLAGS=-L#{CREW_LIB_PREFIX} python2 setup.py build"
      system "LDFLAGS=-L#{CREW_LIB_PREFIX} python3 setup.py build"
    end
  end

  def self.install
    Dir.chdir("python") do
      system "python2 setup.py install --prefix=#{CREW_PREFIX} --root=#{CREW_DEST_DIR}"
      system "python3 setup.py install --prefix=#{CREW_PREFIX} --root=#{CREW_DEST_DIR}"
    end
  end
end
