require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'https://github.com/ColinIanKing/powerstat'
  version '0.04.06'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/powerstat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d35badff9788712149a2593a8e5262cc5f60bbebf60ebe754a4dec7ee9c2b54',
     armv7l: '1d35badff9788712149a2593a8e5262cc5f60bbebf60ebe754a4dec7ee9c2b54',
       i686: 'd0a2d380c846673a72f0bbe11e1139437a9f857995869567be5a4de299d714cc',
     x86_64: '1116cc08bc8f783b806fb3b130c1641b790a56fdb0486da23c57557ab19f47f4'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
