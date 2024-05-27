require 'package'

class Gsl < Package
  description 'The GNU Scientific Library (GSL) is a numerical library for C and C++ programmers.'
  homepage 'https://www.gnu.org/software/gsl/'
  version '2.8'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gsl/gsl-2.8.tar.gz'
  source_sha256 '6a99eeed15632c6354895b1dd542ed5a855c0f15d9ad1326c6fe2b2c9e423190'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '497fc9bf9043263ef4e6e4cee7f4bd880e69043e507c5588acee271670c3a3a1',
     armv7l: '497fc9bf9043263ef4e6e4cee7f4bd880e69043e507c5588acee271670c3a3a1',
       i686: 'c477d1c6a95531270ceb558fdfe108d0fbf966c003dc653fd7e3c014b6e621bb',
     x86_64: '77040ff7e8b9da1e95c93fed6d6f8e8942c3e64ef790a0775303906f82322aed'
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
