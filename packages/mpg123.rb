require 'package'

class Mpg123 < Package
  description 'Fast console MPEG Audio Player and decoder library'
  homepage 'http://www.mpg123.org/'
  version '1.25.10'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/mpg123/mpg123/1.25.10/mpg123-1.25.10.tar.bz2'
  source_sha256 '6c1337aee2e4bf993299851c70b7db11faec785303cfca3a5c3eb5f329ba7023'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mpg123-1.25.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mpg123-1.25.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mpg123-1.25.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mpg123-1.25.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '25786bf03b27a76815ab30e8f3c8e864e7f2f58548b84e092e93f51a074e2515',
     armv7l: '25786bf03b27a76815ab30e8f3c8e864e7f2f58548b84e092e93f51a074e2515',
       i686: 'efe58119727f1d513309661bc643250ce3dff4dfd313a7e8e0b8b3bbdba00baf',
     x86_64: '28edfc1ab64e472a915f6561cb810ed4f69a6ec06d38d7209cef400b823d9328',
  })

  depends_on 'alsa_plugins'
  depends_on 'cras'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-default-audio=oss'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
