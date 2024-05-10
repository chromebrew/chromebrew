require 'package'

class Wkhtmltox < Package
  description 'Convert HTML to PDF using Webkit (QtWebKit)'
  homepage 'https://wkhtmltopdf.org/'
  version '0.12.4'
  license 'LGPL-3'
  compatibility 'x86_64'
  source_url({
    x86_64: 'https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz'
  })
  source_sha256({
    x86_64: '049b2cdec9a8254f0ef8ac273afaf54f7e25459a273e27189591edc7d7cf29db'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxrender' # R
  depends_on 'zlibpkg' # R

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.cp_r 'bin/', CREW_DEST_PREFIX
    FileUtils.cp_r Dir.glob('lib/*'), CREW_DEST_LIB_PREFIX
    FileUtils.cp_r 'share/', CREW_DEST_PREFIX
    FileUtils.cp_r 'include/', CREW_DEST_PREFIX
  end

  def self.postinstall
    ExitMessage.add <<~EOT1.lightpurple
      Note that the wkkhtmlto{image,pdf} programs are vulnerable as per
      CVE-2020-21365 and CVE-2022-35583. As such, please be careful with
      html files that you convert with this package.
    EOT1
  end
end
