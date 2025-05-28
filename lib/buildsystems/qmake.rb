require_relative '../package'
require_relative '../require_gem'
require_relative '../report_buildsystem_methods'

class Qmake < Package
  property :qmake_build_extras, :qmake_install_extras

  def self.build
    extend ReportBuildsystemMethods
    print_buildsystem_methods

    system "QMAKE_CXX='g++ #{ARCH == 'x86_64' && Gem::Version.new(LIBC_VERSION.to_s) >= Gem::Version.new('2.35') ? File.join(CREW_LIB_PREFIX, 'libC.so.6').to_s : ''}' qmake"
    system 'make'
    @qmake_build_extras&.call
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    @qmake_install_extras&.call
  end
end
