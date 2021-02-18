require 'package'

class Libfmt < Package
  description 'A modern formatting library'
  homepage 'https://fmt.dev'
  version '7.1.3'
  compatibility 'all'
  source_url 'https://github.com/fmtlib/fmt/releases/download/7.1.3/fmt-7.1.3.zip'
  source_sha256 '5d98c504d0205f912e22449ecdea776b78ce0bb096927334f80781e720084c9f'

  def self.build
    system "cmake #{CREW_CMAKE_OPTIONS} ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
