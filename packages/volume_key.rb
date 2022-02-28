require 'package'

class Volume_key < Package
  description 'The volume_key project provides a libvolume_key, a library for manipulating
storage volume encryption keys and storing them separately from volumes, and an
associated command-line tool, named volume_key.'
  homepage 'https://pagure.io/volume_key'
  version '0.3.12'    
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://pagure.io/volume_key/archive/volume_key-0.3.12/volume_key-volume_key-0.3.12.tar.gz'
  source_sha256 '8b7941586b711859f568b01f44df87a23081a1c75f40c42b66af3fda10341180'

  depends_on 'cryptsetup' => :build
  depends_on 'glib' => :build
  depends_on 'gpgme' => :build
  depends_on 'libbytesize' => :build
  depends_on 'nss' => :build
  depends_on 'swig' => :build
  
  def self.build
    system "autopoint"
    system "aclocal"
    system "libtoolize"
    system "autoconf"
    system "autoheader"
    system "automake --add-missing"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end