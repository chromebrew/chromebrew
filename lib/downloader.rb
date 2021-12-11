# Defines how chromebrew downloads files.
require_relative 'color'

def notimplemented(package)
  puts "#{package} has not been implemented as a downloader for Chromebrew yet. Defaulting to curl.".orange
  @_crew_downloader = "curl -#LC -"
  def download_file(url, filename)
    system "#{@_crew_downloader} \'#{url}\' --output #{filename}"
  end
end

case ENV["CREW_DOWNLOADER"]
when 'aria2', 'aria2c'
  def download_file(url, filename)
    system "aria2c -c \'#{url}\' --out #{filename}"
  end
when 'curl', '', nil
  def download_file(url, filename)
    system "curl -#LC - \'#{url}\' --output #{filename}"
  end
when 'wget'
  def download_file(url, filename)
    system "wget -c \'#{url}\' --output-document #{filename}"
  end
when 'system curl', 'system'
  def download_file(url, filename)
    system "/usr/bin/curl -#LC - \'#{url}\' --output #{filename}"
  end
when 'fetch', 'bsdfetch', 'libfetch'
  notimplemented 'BSD Fetch'
when 'httpie'
  notimplemented 'HTTPie'
else
  abort "CREW_DOWNLOADER is set to an unknown value. Exiting.".lightred
end
