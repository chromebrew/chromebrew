require 'package'

class Re2 < Package
  description 'RE2 is a fast, safe, thread-friendly alternative to backtracking regular expression engines 
like those used in PCRE, Perl, and Python.'

  homepage 'https://github.com/google/re2/'
  compatibility 'all'
  @_ver = '2021-02-02'
  version @_ver

  source_url "https://github.com/google/re2/archive/#{@_ver}.tar.gz"
  source_sha256 '1396ab50c06c1a8885fb68bf49a5ecfd989163015fd96699a180d6414937f33f'

  def self.build
    # cmake version doesn't provide libre2 library, use make instead
    system 'make'
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} #{CREW_OPTIONS.gsub('--', '')} install"
  end
end