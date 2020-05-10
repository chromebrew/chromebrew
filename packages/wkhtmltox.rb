require 'package'

class Wkhtmltox < Package
  description 'Convert HTML to PDF using Webkit (QtWebKit)'
  homepage 'https://wkhtmltopdf.org/'
  version '0.12.4-1'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url ({
        i686: 'https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-i386.tar.xz',
      x86_64: 'https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz',
    })
    source_sha256 ({
        i686: '4087b264ec860ab0b0f9b7299ef733fc51e8e39f42047a06724b7450016ab9b8',
      x86_64: '049b2cdec9a8254f0ef8ac273afaf54f7e25459a273e27189591edc7d7cf29db',
    })
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/wkhtmltox-0.12.4-1-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wkhtmltox-0.12.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '6b8fea9c8369203b53d57d3b1f3f22789379a72122d4fda19980aa0622e59717',
    x86_64: '51b6abcd0d037008c01b043b75c0679f10e105808aacb69be6e7d313c842516c',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r 'bin/', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r Dir.glob('lib/*'), "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r 'share/', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r 'include/', "#{CREW_DEST_PREFIX}"
  end
end
