require 'package'

class Yara < Package
  description 'The pattern matching swiss knife for malware researchers (and everyone else).'
  homepage 'https://virustotal.github.io/yara/'
  version '4.2.3'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/VirusTotal/yara/archive/v4.2.3.tar.gz'
  source_sha256 '1cd84fc2db606e83084a648152eb35103c3e30350825cb7553448d5ccde02a0d'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yara/4.2.3_armv7l/yara-4.2.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yara/4.2.3_armv7l/yara-4.2.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yara/4.2.3_i686/yara-4.2.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yara/4.2.3_x86_64/yara-4.2.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ddbebdd46dbe4d0da19fde9596b1e4c0c33a6a2a25abe88c07e4f7d41d1d05fb',
     armv7l: 'ddbebdd46dbe4d0da19fde9596b1e4c0c33a6a2a25abe88c07e4f7d41d1d05fb',
       i686: '0bdee5b010c9765aa14c0fea82866914c087814e0ca540e460e17176020cf404',
     x86_64: 'd63b0bcb7feb4eef29d8271dd008d9c4cf9825eecc9e12cddde8b875d2457e8a'
  })

  def self.build
    system './bootstrap.sh'
    system "YACC=bison ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
