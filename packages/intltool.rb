require 'package'

class Intltool < Package
  description 'intltool is a set of tools to centralize translation of many different file formats using GNU gettext-compatible PO files.'
  homepage 'https://freedesktop.org/wiki/Software/intltool/'
  version '0.51.0-1'
  compatibility 'all'
  source_url 'https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz'
  source_sha256 '67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/intltool-0.51.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/intltool-0.51.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/intltool-0.51.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/intltool-0.51.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '47c82f3b2e4d6c2959ee1edf1d8dc480eb4e28e0bfac9efc823be7d937bfadcb',
     armv7l: '47c82f3b2e4d6c2959ee1edf1d8dc480eb4e28e0bfac9efc823be7d937bfadcb',
       i686: '41acb4802df44c0264e496a6a20c96a8db8bf5626d6214a72dee58f26a2caa9a',
     x86_64: '128c16c438bcf23d0d9cc27afe947c7ece5e5ba96d96dd5838d3550f702bfe40',
  })

  depends_on 'libtool'
  depends_on 'perl_xml_parser'
  depends_on 'patch' => :build
  depends_on 'wget' => :build
  
  def self.patch
    system "wget https://raw.githubusercontent.com/Alexpux/MSYS2-packages/master/intltool/perl-5.22-compatibility.patch"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('perl-5.22-compatibility.patch') ) == '9c6527072aada6e3cb9aceb6e07cfdf51d58839a2beb650168da0601a85ebda3'
    system "patch intltool-update.in perl-5.22-compatibility.patch"
  end
  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
