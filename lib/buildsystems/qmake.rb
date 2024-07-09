require 'package'

class Qmake < Package
  property :qmake_install_extras

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    @qmake_install_extras&.call
  end
end
