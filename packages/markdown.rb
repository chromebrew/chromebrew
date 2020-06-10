require 'package'

class Markdown < Package
  description 'Markdown is a text-to-HTML conversion tool for web writers.'
  homepage 'https://daringfireball.net/projects/markdown/'
  version '1.0.1'
  compatibility 'all'
  source_url 'http://daringfireball.net/projects/downloads/Markdown_1.0.1.zip'
  source_sha256 '6520e9b6a58c5555e381b6223d66feddee67f675ed312ec19e9cee1b92bc0137'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/markdown-1.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/markdown-1.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/markdown-1.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/markdown-1.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bc5c8f4b5fe7ad5239d57b442c390cbdebb2fe94f84a1e854126c3999c296dae',
     armv7l: 'bc5c8f4b5fe7ad5239d57b442c390cbdebb2fe94f84a1e854126c3999c296dae',
       i686: 'b19b75211a47096ebf43a4e42c335526833543b259e18a51bd96de2bd85abdf5',
     x86_64: 'aa7a1d7664c25efad0a2874dfc3a07653bcd5ee0998bb87cf02da1815ece608e',
  })

  depends_on 'unzip' => :build
  depends_on 'perl'

  def self.install
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' Markdown.pl"
    system "install -Dm755 Markdown.pl #{CREW_DEST_PREFIX}/bin/markdown"
  end
end
