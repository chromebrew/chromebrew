require 'package'

class Alive < Package
  description 'Automatic login and keep-alive utility for Internet connections.'
  homepage 'https://www.gnu.org/software/alive/'
  version '2.0.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/alive/alive-2.0.3.tar.xz'
  source_sha256 '8bf41150ade07b86a806ce40ce99509713e2abcc92c4182a8d961aa3cf757014'

  depends_on 'guile'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
