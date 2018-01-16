require 'package'

class Markdown < Package
  description 'Markdown is a text-to-HTML conversion tool for web writers.'
  homepage 'https://daringfireball.net/projects/markdown/'
  version '1.0.1'
  source_url 'http://daringfireball.net/projects/downloads/Markdown_1.0.1.zip'
  source_sha256 '6520e9b6a58c5555e381b6223d66feddee67f675ed312ec19e9cee1b92bc0137'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'unzip' => :build
  depends_on 'perl'

  def self.install
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' Markdown.pl"
    system "install -Dm755 Markdown.pl #{CREW_DEST_PREFIX}/bin/markdown"
  end
end
