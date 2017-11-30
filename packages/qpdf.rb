require 'package'

class Qpdf < Package
  description 'QPDF is a command-line program that does structural, content-preserving transformations on PDF files.'
  homepage 'http://qpdf.sourceforge.net/'
  version '7.0.b1'
  source_url 'https://github.com/qpdf/qpdf/archive/release-qpdf-7.0.b1.tar.gz'
  source_sha256 '2e0a26f7a03fe41c72be8e95c420744f98dbf553e025fb0d4c990f83df023d90'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qpdf-7.0.b1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qpdf-7.0.b1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qpdf-7.0.b1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qpdf-7.0.b1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2d01edee3bbe5b8d8b8bee704889307dbe48fe5fdb6b064516b1a290be8bc2fa',
     armv7l: '2d01edee3bbe5b8d8b8bee704889307dbe48fe5fdb6b064516b1a290be8bc2fa',
       i686: '851a7ad6e4f60feac3b0acd592649e784837d774e76916c153881db895b8df6e',
     x86_64: '980b28cfb28952ba95560acf4745dd0ef899c3be2fe04b9d343a89a28f566e28',
  })

  def self.build
    system './autogen.sh'
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
