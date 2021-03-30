require 'package'

class Screen < Package
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '4.6.2-1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/screen/screen-4.6.2.tar.gz'
  source_sha256 '1b6922520e6a0ce5e28768d620b0f640a6631397f95ccb043b70b91bb503fa3a'

  depends_on 'ncursesw'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
