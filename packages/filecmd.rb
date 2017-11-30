require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.32'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.32.tar.gz'
  source_sha256 '8639dc4d1b21e232285cd483604afc4a6ee810710e00e579dbe9591681722b50'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'af400fed3c8232bc161c7e9bdb7ced47a435865def9bd540364efe1f65c6e520',
     armv7l: 'af400fed3c8232bc161c7e9bdb7ced47a435865def9bd540364efe1f65c6e520',
       i686: '79488beffd9b35c6eddf324a2ac70bd9b7b6fdfa823000be7820b1a8dc3c1ffd',
     x86_64: '9bf523018a4bcb2e4e08dbb52fed66e0c3d515d9595fb5631706b99f70a42c59',
  })

  def self.build
    system "./configure --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
