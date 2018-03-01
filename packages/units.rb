require 'package'

class Units < Package
  description 'GNU Units converts quantities expressed in various systems of measurement to their equivalents in other systems of measurement.'
  homepage 'https://www.gnu.org/software/units/units.html'
  version '2.16'
  source_url 'https://ftp.gnu.org/gnu/units/units-2.16.tar.gz'
  source_sha256 'dcf3f78482a13b150fc6bf0f8d611510816a3424bc2b26229b85b1cadeb81686'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/units-2.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/units-2.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/units-2.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/units-2.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b2eb014f6c3c3c2b5d7c238c7b3be53707e01e78154feff8af599d183a8ac524',
     armv7l: 'b2eb014f6c3c3c2b5d7c238c7b3be53707e01e78154feff8af599d183a8ac524',
       i686: '2f9a42090de1462c5c072e49a74fca296975c6cd32fd82d4572dcd672a792c62',
     x86_64: 'db36428275e1b1d9bcaf702f527e4b9d7dd5cba83c2cdaff8191f60924777ef9',
  })

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
