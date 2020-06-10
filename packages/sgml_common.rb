require 'package'

# from LFS: http://www.linuxfromscratch.org/blfs/view/cvs/pst/sgml-common.html

class Sgml_common < Package
  description 'The sgml-common package gathers very basic stuff necessary to work with SGML and XML.'
  homepage 'https://sourceware.org/docbook-tools/'
  version '0.6.3'
  compatibility 'all'
  source_url 'https://sourceware.org/ftp/docbook-tools/new-trials/SOURCES/sgml-common-0.6.3.tgz'
  source_sha256 '7dc418c1d361123ffc5e45d61f1b97257940a8eb35d0bfbbc493381cc5b1f959'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sgml_common-0.6.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sgml_common-0.6.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sgml_common-0.6.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sgml_common-0.6.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '18ff17ac8af52e6e6790564c49155d5c2e8e05583d514744af1e30502d4a79b8',
     armv7l: '18ff17ac8af52e6e6790564c49155d5c2e8e05583d514744af1e30502d4a79b8',
       i686: '8bae935790db5a8b6aa63cc76e9c8c568681a7bf66e505f3c2be872f5e713338',
     x86_64: '48fcb41950ca59883d56b7285608121150c6a2c4969579847467606610d7c0a8',
  })

  def self.patch
    system 'wget http://www.linuxfromscratch.org/patches/blfs/svn/sgml-common-0.6.3-manpage-1.patch'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('sgml-common-0.6.3-manpage-1.patch') ) == '50d93af704a0869faf8fedf5d23b1a9f90fff6499f4c11cf4addb5e460b7b58b'
    system 'patch -Np1 -i sgml-common-0.6.3-manpage-1.patch && autoreconf -f -i'
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/sgml"
    system "touch #{CREW_DEST_PREFIX}/etc/sgml/sgml-ent.cat"
    system "touch #{CREW_DEST_PREFIX}/etc/sgml/sgml-docbook.cat"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/sgml/sgml-iso-entities-8879.1986"
    system "touch #{CREW_DEST_PREFIX}/share/sgml/sgml-iso-entities-8879.1986/catalog"
    system "sed -i 's,/etc/sgml,#{CREW_PREFIX}/etc/sgml,g' #{CREW_DEST_PREFIX}/bin/install-catalog"
  end

  def self.postinstall
    system "install-catalog --add #{CREW_PREFIX}/etc/sgml/sgml-ent.cat \
            #{CREW_PREFIX}/share/sgml/sgml-iso-entities-8879.1986/catalog &&
            install-catalog --add #{CREW_PREFIX}/etc/sgml/sgml-docbook.cat \
            #{CREW_PREFIX}/etc/sgml/sgml-ent.cat"
  end
end
