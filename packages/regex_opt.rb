require 'package'

class Regex_opt < Package
  description 'Perl-compatible regular expression optimizer'
  homepage 'https://bisqwit.iki.fi/source/regexopt.html'
  version '1.2.4'
  source_url 'https://bisqwit.iki.fi/src/arch/regex-opt-1.2.4.tar.gz'
  source_sha256 '128c8ba9570b1fd8a6a660233de2f5a4022740bc5ee300300709c3894413883f'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,PREFIX=/usr/local,PREFIX=#{CREW_PREFIX},' Makefile"
    system "make"
  end

  def self.install
    system "install -Dm755 regex-opt #{CREW_DEST_PREFIX}/bin/regex-opt"
  end
end
