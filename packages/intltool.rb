require 'package'

class Intltool < Package
  description 'intltool is a set of tools to centralize translation of many different file formats using GNU gettext-compatible PO files.'
  homepage 'https://freedesktop.org/wiki/Software/intltool/'
  version '0.51.0'
  source_url 'https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz'
  source_sha256 '67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd'

  depends_on 'libtool'
  depends_on 'perl_xml_parser'
  depends_on 'patch' => 'build'

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
