require 'package'

class Qmake < Package
  property :qmake_build_extras, :qmake_install_extras

  def self.build
    system 'qmake'
    system 'make'
    @qmake_build_extras&.call
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    @qmake_install_extras&.call
  end
end
