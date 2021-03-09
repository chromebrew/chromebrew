require 'package'

class Re2 < Package
  description 'RE2 is a fast, safe, thread-friendly alternative to backtracking regular expression engines like those used in PCRE, Perl, and Python.'
  homepage 'https://github.com/google/re2/'
  compatibility 'all'
  @_ver = '2021-02-02'
  version @_ver

  source_url "https://github.com/google/re2/archive/#{@_ver}.tar.gz"
  source_sha256 '1396ab50c06c1a8885fb68bf49a5ecfd989163015fd96699a180d6414937f33f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/re2-2021-02-02-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/re2-2021-02-02-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/re2-2021-02-02-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/re2-2021-02-02-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    aarch64: 'ae5d5606c670ae8b7a1d6faae048683e2a68a49594e3955ba422924d0e236b6a',
     armv7l: 'ae5d5606c670ae8b7a1d6faae048683e2a68a49594e3955ba422924d0e236b6a',
       i686: '0405d43ceba95bc74cd1d301d7fc32441599f22686fcf05850376fb32044bfff',
     x86_64: '669255b395f866889afadd99b31c34a94f7c6ede80e1292a42c6126cedf90315'
  })

  def self.build
    # cmake version doesn't provide libre2 library, use make instead
    system 'make'
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} #{CREW_OPTIONS.gsub('--', '')} install"
  end
end
