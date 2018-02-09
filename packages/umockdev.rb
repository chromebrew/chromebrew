
require 'package'

class Umockdev < Package
  description 'Mock hardware devices for creating unit tests and bug reporting'
  homepage 'https://github.com/martinpitt/umockdev/'
  version '0.9.4'  # stable version
  source_url 'https://github.com/martinpitt/umockdev/archive/0.9.4.tar.gz'
  source_sha256 '9f13e8a836ef36158e2cc2b679cb99639e1f68a430b04fbe4dd07d3cb2b32a75'

  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'intltool' => :build
  depends_on 'python27'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
 end

end
