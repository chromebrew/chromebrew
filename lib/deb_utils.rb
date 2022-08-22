module DebUtils
  def self.extract_deb(file, target)
    # extract_deb: unarchive .deb files
    # Usage: extract_deb(<file>, <target (optional)>)
    #   file: a .deb archive file
    #   target: (optional) a specified file to extract from archive, should be passed in regex or string
    #
    # Example:
    #   extract_deb('example.deb', 'test.txt') # extract `test.txt` from example.deb
    #   extract_deb('example.deb', /data\..*/) # extract files from example.deb with filenames matching the /data\..*/ regex
    #   extract_deb('example.deb', /*/)        # extract all files from example.deb
    #
    file_found = false
    src_fileIO = File.open(file, 'rb')
    file_size = src_fileIO.size
    # get first line of the given file, should be a signature string (`!<arch>\n`) if it is a valid deb file
    signature = src_fileIO.gets

    abort 'Malformed archive :/'.lightred unless signature == "!<arch>\n"

    # process each file in archive
    while (line = src_fileIO.gets)
      if line.chomp.empty? && (file_size == src_fileIO.tell)
        # early return if trailing newline is detected
        break
      elsif line.chomp.empty?
        warn "Unexpected newline in offset #{src_fileIO.tell}, ignoring...".yellow
        next
      end

      # read file meta
      name, modtime, uid, gid, mode, size, end_char = \
        line.scan(/(.{16})(.{12})(.{6})(.{6})(.{8})(.{10})(.{1})/).flatten.map(&:strip)

      # remove slash suffix from filename (if any)
      # (a `.deb` ar archive does not support any directories, so we can confirm that all entries are normal files)
      name&.sub!(%r{/$}, '')

      # check ending byte
      abort 'Malformed archive :/'.lightred unless end_char == '`'

      # capture file in archive with given offset bytes (file size)
      fileContent = src_fileIO.read(size.to_i)

      # filter filename if a target file is specified
      if target.is_a?(String) && (name == target)
        # if target is passed as string, write matched file to filesyetem and exit function
        # write to filesystem
        return File.binwrite(name, fileContent, perm: mode.to_i(8))
      elsif target.is_a?(Regexp) && name =~ (target)
        # if target is passed as regex, write matched file to filesyetem and continue
        # searching for another matched file until EOF
        # write to filesystem
        File.binwrite(name, fileContent, perm: mode.to_i(8))
        file_found = true
      end
    end
    abort "Target #{target.inspect} not found in archive. :/".lightred unless file_found
  end
end
