require 'package'

class Icu4c < Package
  description 'ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications.'
  homepage 'http://site.icu-project.org/'
  version '58.2'
  source_url 'http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz'
  source_sha256 '2b0a4410153a9b20de0e20c7d8b66049a72aef244b53683d0d7521371683da0c'

  def self.build
    FileUtils.cd('source') do
      system "./configure", "--without-samples", "--without-tests"
      system "make"
    end
  end

  def self.install
    FileUtils.cd('source') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
