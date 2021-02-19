require 'package'

class Findutils < Package
  description 'the basic directory searching utilities of the GNU operating system'
  homepage 'https://www.gnu.org/software/findutils/'
  version '4.8.0'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/findutils/findutils-4.8.0.tar.xz'
  source_sha256 '57127b7e97d91282c6ace556378d5455a9509898297e46e10443016ea1387164'

  depends_on 'python3'
  

  ENV['PYTHON'] = "python3" #Force use of python3 over python2.7
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --without-selinux"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
