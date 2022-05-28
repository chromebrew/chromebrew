require 'package'

class Libfmt < Package
  description 'A modern formatting library'
  homepage 'https://fmt.dev'
  version '8.1.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/fmtlib/fmt/releases/download/8.1.1/fmt-8.1.1.zip'
  source_sha256 '23778bad8edba12d76e4075da06db591f3b0e3c6c04928ced4a7282ca3400e5d'

  def self.build
    Dir.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake #{CREW_CMAKE_OPTIONS} \
              -DBUILD_SHARED_LIBS=TRUE \
              .."
      system "make"
    end
  end

  def self.install
    Dir.chdir "builddir" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end

  def self.check
    Dir.chdir "builddir" do
      system "make", "test"
    end
  end
end
