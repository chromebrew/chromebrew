require 'package'

class Datamash < Package
  description 'GNU Datamash is a command-line program which performs basic numeric,textual and statistical operations on input textual data files.'
  homepage 'http://savannah.gnu.org/projects/datamash'
  version '1.1.1'
  source_url 'https://ftpmirror.gnu.org/datamash/datamash-1.1.1.tar.gz'
  source_sha256 '420819b3d7372ee3ce704add847cff7d08c4f8176c1d48735d4a632410bb801b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e664ff3f0882182ae85207bd1206fe71c0f7cbd57f32dca37791ed9ec4dc51e0',
     armv7l: 'e664ff3f0882182ae85207bd1206fe71c0f7cbd57f32dca37791ed9ec4dc51e0',
       i686: '6bddfe6f7e92197c65c64ec2ee39cd88f57eafa96f93496bf058174f33eae882',
     x86_64: '179497c275e0f4f51c0c6512515d0bbe9bbcd8397b0737e45ff63be4acb907d7',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
