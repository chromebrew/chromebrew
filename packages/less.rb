require 'package'

class Less < Package
  description 'GNU less is a program similar to more, but which allows backward movement in the file as well as forward movement.'
  homepage 'https://www.gnu.org/software/less/'
  version '608'
  license 'GPL-3 or BSD-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/less/less-608.tar.gz'
  source_sha256 'a69abe2e0a126777e021d3b73aa3222e1b261f10e64624d41ec079685a6ac209'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/608_armv7l/less-608-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/608_armv7l/less-608-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/608_i686/less-608-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/less/608_x86_64/less-608-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5a945772c06719f52ac9d8435a64611d53c29714e7f9c34fc342c38c1912afda',
     armv7l: '5a945772c06719f52ac9d8435a64611d53c29714e7f9c34fc342c38c1912afda',
       i686: 'ed9e9b0d5edd476252dc909aa9753e81d0aa4f8167d624ac6d1d6956d18d75ea',
     x86_64: 'd19353c6ea34e7da8554eab1ec322b655bc581232bc48ecff28fb852420265b1'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc' # R

  def self.build
    system "./configure #{CREW_OPTIONS} --with-regex=posix"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
