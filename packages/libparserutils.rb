require 'package'

class Libparserutils < Package
  description 'Library for building efficient parsers, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.2.4'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libparserutils-0.2.4-src.tar.gz'
  source_sha256 '322bae61b30ccede3e305bf6eae2414920649775bc5ff1d1b688012a3c4947d8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libparserutils-0.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libparserutils-0.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libparserutils-0.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libparserutils-0.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f6cf71d523cc7846199ae7cc8fccb712981ea1d1bad0672a83f602b4dc054c38',
     armv7l: 'f6cf71d523cc7846199ae7cc8fccb712981ea1d1bad0672a83f602b4dc054c38',
       i686: 'cf81d606dddc0f9c0667d5b53f656f4e282fcf1aefd7d0e7e75a35d467faf88f',
     x86_64: '3f571ae3599d8623b433faf79944f3be1598fc1aaefdfd555cde4882bcc4936c',
  })

  depends_on 'netsurf_buildsystem' => :build

  def self.build
    system "make PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared"
  end

  def self.install
    system "make install PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared DESTDIR=#{CREW_DEST_DIR}"
    case ARCH
    when 'x86_64'
      Dir.chdir CREW_DEST_PREFIX do
        FileUtils.mv 'lib/', 'lib64/'
      end
    end
  end
end
