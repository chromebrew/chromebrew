# Adapted from Arch Linux adobe-source-code-pro-fonts PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/adobe-source-code-pro-fonts/trunk/PKGBUILD

require 'package'

class Adobe_source_code_pro_fonts < Package
  description 'Monospaced font family for user interface and coding environments'
  homepage 'https://adobe-fonts.github.io/source-code-pro/'
  version '20210115'
  license 'OFL-1.1'
  compatibility 'all'
  source_url 'https://github.com/adobe-fonts/source-code-pro.git'
  git_hashtag '2.038R-ro/1.058R-it/1.018R-VAR'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adobe_source_code_pro_fonts/20210115_armv7l/adobe_source_code_pro_fonts-20210115-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adobe_source_code_pro_fonts/20210115_armv7l/adobe_source_code_pro_fonts-20210115-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adobe_source_code_pro_fonts/20210115_i686/adobe_source_code_pro_fonts-20210115-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adobe_source_code_pro_fonts/20210115_x86_64/adobe_source_code_pro_fonts-20210115-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '22858b9d32b3911f42ce9d38d762a0bda58500dc936bec1a6d15600c3918c27b',
     armv7l: '22858b9d32b3911f42ce9d38d762a0bda58500dc936bec1a6d15600c3918c27b',
       i686: 'f5675e683e54148c6cb6a731913b43ac1be36f20b95828398618dcb7bce04762',
     x86_64: '572b83ce1c1370f590800a253b5b69dac29953f3dd29e5177ac658894987d265'
  })

  depends_on 'fontconfig'

  def self.install
    system "install -Dt #{CREW_DEST_PREFIX}/share/fonts/adobe-source-code-pro-fonts -m644 OTF/*.otf VAR/*.otf"
  end

  def self.postinstall
    system 'fc-cache -f'
  end
end
