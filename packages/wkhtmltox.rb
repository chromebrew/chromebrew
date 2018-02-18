require 'package'

class Wkhtmltox < Package
  description 'Convert HTML to PDF using Webkit (QtWebKit)'
  homepage 'https://wkhtmltopdf.org/'
  version '0.12.4'
  case ARCH
  when 'i686'
    source_url 'https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-i386.tar.xz'
    source_sha256 '4087b264ec860ab0b0f9b7299ef733fc51e8e39f42047a06724b7450016ab9b8'
  when 'x86_64'
    source_url 'https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz'
    source_sha256 '049b2cdec9a8254f0ef8ac273afaf54f7e25459a273e27189591edc7d7cf29db'
  end

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wkhtmltox-0.12.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wkhtmltox-0.12.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '49df2dd2e7d9bda0e8cc4b29d186df54a49f03b7a3ad4125d835732edf0d0c01',
     x86_64: 'b2084816bae9c21d3ebd1e68f4ec4661b8e08426161b10841f80488c71aac7af',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r lib/ #{CREW_DEST_PREFIX}"
    system "cp -r share/ #{CREW_DEST_PREFIX}"
    system "cp -r include/ #{CREW_DEST_PREFIX}"
  end
end
